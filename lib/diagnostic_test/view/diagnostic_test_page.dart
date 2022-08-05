import 'package:adeo_testapp/diagnostic_test/bloc/diagnostic_test_bloc.dart';
import 'package:adeo_testapp/diagnostic_test/bloc/timer_bloc.dart';
import 'package:adeo_testapp/diagnostic_test/models/answer.dart';
import 'package:adeo_testapp/diagnostic_test/repositories/diagnostic_test_repository.dart';
import 'package:adeo_testapp/diagnostic_test/timer.dart';
import 'package:adeo_testapp/diagnostic_test/widgets/diagnostic_test_header.dart';
import 'package:adeo_testapp/routes.gr.dart';
import 'package:adeo_testapp/theme/colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class DiagnosticTestPage extends StatelessWidget {
  const DiagnosticTestPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const DiagnosticTestPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DiagnosticTestBloc>(context)
        ..add(DiagnosticTestLoaded()),
      child: const DiagnosticTestView(),
    );
  }
}

class DiagnosticTestView extends StatelessWidget {
  const DiagnosticTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<DiagnosticTestBloc, DiagnosticTestState>(
            listener: (context, state) {
              final timerState = context.read<TimerBloc>().state;

              if (state.status == DiagnosticTestStatus.success &&
                  timerState is! TimerRunInProgress &&
                  timerState is! TimerRunComplete) {
                context.read<TimerBloc>().add(const TimerStarted(duration: 2));
              }
            },
          ),
          BlocListener<TimerBloc, TimerState>(
            listener: (context, state) async {
              final timerState = context.read<TimerBloc>().state;

              if (timerState is TimerRunComplete) {
                await _showTimeElapsedDialog(context);
                Future.delayed(
                  const Duration(milliseconds: 250),
                  () =>
                      context.router.replace(const DiagnosticTestReviewRoute()),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: state.status != DiagnosticTestStatus.success
                  ? Builder(
                      builder: (context) {
                        if (state.status == DiagnosticTestStatus.failure) {
                          return ColoredBox(
                            color: Theme.of(context).colorScheme.secondary,
                            child: const Center(
                              child: Text(
                                'Failed to Load Test',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else if (state.status ==
                            DiagnosticTestStatus.initial) {
                          return ColoredBox(
                            color: Theme.of(context).primaryColor,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    )
                  : Column(
                      children: [
                        const DiagnosticTestHeader(),
                        BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
                            builder: (context, state) {
                          final currentIndex = state.currentQuestionIndex;
                          final question = state.questions[currentIndex];
                          final answers = question.answers;
                          final hasResources = question.resource.isNotEmpty;
                          return Expanded(
                            child: Column(
                              children: [
                                Container(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  height: 150,
                                  child: Center(
                                    child: Html(
                                      data: question.text,
                                      style: {
                                        // tables will have the below background color
                                        '*': Style(
                                          color: Colors.white,
                                          fontSize: const FontSize(25),
                                          textAlign: TextAlign.center,
                                        ),
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  color: AppColors.lightSecondary,
                                  height: 80,
                                  child: const Center(
                                    child: Text(
                                      'Choose the right answer to the question above',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: hasResources
                                      ? Row(
                                          children: [
                                            // Question Section
                                            Expanded(
                                              child:
                                                  buildResourceSection(context),
                                            ),

                                            // End of Question Section

                                            // Start of Answer Section
                                            Expanded(
                                              child:
                                                  buildAnswerSection(answers),
                                            ),
                                            // End of Answer Section
                                          ],
                                        )
                                      : ColoredBox(
                                          color: AppColors.darkBlue,
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                child: SizedBox(),
                                              ),

                                              // Start of Answer Section
                                              Expanded(
                                                flex: 2,
                                                child:
                                                    buildAnswerSection(answers),
                                              ),
                                              // End of Answer Section

                                              const Expanded(
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                )
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showTimeElapsedDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Time Up')),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Center(child: Text('Test time has elapsed')),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: AppColors.primaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              onPressed: () {
                context.router.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildAnswerSection(List<Answer> answers) {
    return BlocListener<DiagnosticTestBloc, DiagnosticTestState>(
      listenWhen: (previous, current) =>
          previous.chosenAnswers != current.chosenAnswers,
      listener: (context, state) {
        Future.delayed(
          const Duration(milliseconds: 2000),
          () => context.read<DiagnosticTestBloc>().add(
                DiagnosticTestNextQuestionRequested(),
              ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 120,
          vertical: 30,
        ),
        color: AppColors.darkBlue,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemCount: answers.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnswerOption(
                    answer: answers[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: const [
                Expanded(
                  child: QuestionNavButton(
                    text: 'Previous',
                    type: NavType.prev,
                  ),
                ),
                SizedBox(width: 1),
                Expanded(
                  child: QuestionNavButton(
                    text: 'Next',
                    type: NavType.next,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildResourceSection(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        children: [
          const ExplanationNavButton(
            icon: Icons.chevron_left,
          ),
          Expanded(
            child: SizedBox(
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 100,
                    left: 40,
                    right: 40,
                    bottom: 50,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'The Story of Ananse',
                        style: TextStyle(
                          fontFamily: 'Hamelin',
                          fontSize: 50,
                          color: Color(0xFFa5d0ff),
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 5,
                              color: AppColors.reviewDarkTextColor,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
          ),
          const ExplanationNavButton(
            icon: Icons.chevron_right,
          ),
        ],
      ),
    );
  }
}

class AnswerOption extends StatelessWidget {
  const AnswerOption({
    super.key,
    required this.answer,
  });

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
      builder: (context, state) {
        final questionHasBeenAnswered =
            state.chosenAnswers[answer.questionId] != null;
        final isChosen = state.chosenAnswers[answer.questionId] == answer.id;
        // final isChosenAndRight = isChosen && answer.isRightAnswer;
        final isChosenAndWrong = isChosen && !answer.isRightAnswer;

        return InkWell(
          onTap: () {
            if (!questionHasBeenAnswered) {
              context.read<DiagnosticTestBloc>().add(
                    DiagnosticTestAnswerSelected(
                      answer: answer,
                    ),
                  );
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: questionHasBeenAnswered && isChosen
                ? BoxDecoration(
                    color: AppColors.secondaryColor,
                    border: Border.all(
                      color: AppColors.primaryBlue,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  )
                : const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (questionHasBeenAnswered)
                    if (isChosen || answer.isRightAnswer)
                      CircleAvatar(
                        backgroundColor: answer.isRightAnswer
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                        child: Icon(
                          answer.isRightAnswer ? Icons.check : Icons.close,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Center(
                      child: Html(
                        data: answer.text,
                        style: {
                          '*': Style(
                            color: isChosenAndWrong
                                ? Colors.red
                                : questionHasBeenAnswered &&
                                        answer.isRightAnswer
                                    ? AppColors.primaryColor
                                    : Colors.white70,
                            fontSize: FontSize(isChosenAndWrong ? 40 : 30),
                            textAlign: TextAlign.center,
                          ),
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ExplanationNavButton extends StatelessWidget {
  const ExplanationNavButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => print('Next'),
      icon: Icon(icon),
      iconSize: 70,
      color: AppColors.lightSecondary,
    );
  }
}

class QuestionNavButton extends StatelessWidget {
  const QuestionNavButton({
    super.key,
    required this.text,
    required this.type,
  });

  final String text;
  final NavType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () => type == NavType.next
            ? context
                .read<DiagnosticTestBloc>()
                .add(DiagnosticTestNextQuestionRequested())
            : context
                .read<DiagnosticTestBloc>()
                .add(DiagnosticTestPreviousQuestionRequested()),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side: BorderSide.none,
          primary: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

enum NavType {
  prev,
  next,
}
