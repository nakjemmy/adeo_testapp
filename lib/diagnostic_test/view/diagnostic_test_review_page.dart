import 'package:adeo_testapp/diagnostic_test/bloc/diagnostic_test_bloc.dart';
import 'package:adeo_testapp/diagnostic_test/widgets/diagnostic_test_review_section_header.dart';
import 'package:adeo_testapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_switch/flutter_switch.dart';

class DiagnosticTestReviewPage extends StatelessWidget {
  const DiagnosticTestReviewPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const DiagnosticTestReviewPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const DiagnosticTestReviewView();
  }
}

class DiagnosticTestReviewView extends StatelessWidget {
  const DiagnosticTestReviewView({super.key});

  bool get questionHasExplanation => true;
  bool get isShowingQuestionDetails => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(64),
                color: const Color(0xfff6f6f6),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const MainScoreSummary(),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(thickness: 5, color: Colors.white),
                        ),
                        const SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: ColoredBox(
                            color: AppColors.primaryBlue,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return ToggleButtons(
                                isSelected: const [true, false],
                                fillColor: const Color(0xFF2589ce),
                                selectedColor: AppColors.primaryBlue,
                                borderWidth: 0,
                                borderColor: Colors.transparent,
                                children: <Widget>[
                                  SizedBox(
                                    width: constraints.maxWidth * .3,
                                    child: const Text(
                                      'Topics',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * .3,
                                    child: const Text(
                                      'Questions',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                                onPressed: (int index) {},
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .5,
                          child: buildTopics(),
                        ),
                        const SizedBox(height: 50),
                        buildSummaryActions(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
                color: AppColors.darkBlue,
                child: isShowingQuestionDetails
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: DiagnosticTestReviewSectionsHeader(),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  primary: AppColors.primaryBlue,
                                  side: const BorderSide(
                                    color: AppColors.reviewBodyTextColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                  child: Text(
                                    'History',
                                    style: TextStyle(
                                      color: AppColors.reviewBodyTextColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          Expanded(
                            child: BlocBuilder<DiagnosticTestBloc,
                                DiagnosticTestState>(
                              builder: (context, state) {
                                return ListView.builder(
                                  itemCount:
                                      state.currentFilteredQuestions.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final question =
                                        state.currentFilteredQuestions[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: ReviewQuestionItem(
                                        text: question.text,
                                        index: index,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'This was a free diagnostic test',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                          const SizedBox(height: 50),
                          const Text(
                            'Buy a subscription to unlock the entire course',
                            style: TextStyle(
                              color: AppColors.reviewBodyTextColor,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 120),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff07c4ff),
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.4),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Store',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 150,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xffff8071),
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.4),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSummaryActions() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                child: ReviewGroupButtonItem(
                  text: 'review',
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                child: ReviewGroupButtonItem(
                  text: 'revise',
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                child: ReviewGroupButtonItem(
                  text: 'new test',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTopics() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                '%',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 25,
                ),
              ),
              const SizedBox(width: 7),
              BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
                builder: (context, state) {
                  return FlutterSwitch(
                    value: state.showTopicScoreAsPercentage,
                    toggleSize: 15,
                    height: 20,
                    width: 40,
                    activeColor: AppColors.primaryBlue,
                    onToggle: (val) {
                      context
                          .read<DiagnosticTestBloc>()
                          .add(ReviewtTopicsScorePercentageDisplayToggled());
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TopicItem(
                      index: index,
                      score: 8,
                      total: 10,
                      title: 'Cells',
                      remarks: 'Excellent perfomance',
                      asPercentage: state.showTopicScoreAsPercentage,
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class TopicItem extends StatelessWidget {
  const TopicItem({
    super.key,
    required this.index,
    required this.title,
    required this.remarks,
    required this.total,
    required this.score,
    this.asPercentage = false,
    this.isSelected = false,
  });

  final int index;
  final String title;
  final String remarks;
  final bool asPercentage;
  final bool isSelected;
  final int total;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: isSelected ? AppColors.primaryBlue : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                remarks,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color:
                      isSelected ? Colors.white : AppColors.reviewBodyTextColor,
                ),
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: asPercentage
                ? Text(
                    '${((score / total) * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: isSelected ? Colors.white : AppColors.primaryBlue,
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      text: '$score',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color:
                            isSelected ? Colors.white : AppColors.primaryBlue,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '/$total',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class MainScoreSummary extends StatelessWidget {
  const MainScoreSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildSummaryItem(
              ((state.score / state.totalQuestions) * 100).toStringAsFixed(0),
              'Score',
            ),
            buildSummaryItem('01:30', 'Time taken'),
            buildSummaryItem(state.questions.length.toString(), 'Questions'),
          ],
        );
      },
    );
  }

  Column buildSummaryItem(String text, String description) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: AppColors.reviewDarkTextColor,
            shadows: <Shadow>[
              Shadow(
                blurRadius: 2,
                color: AppColors.reviewDarkTextColor,
              ),
            ],
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.reviewBodyTextColor,
          ),
        ),
      ],
    );
  }
}

class AnswerItem extends StatelessWidget {
  const AnswerItem({
    super.key,
    required this.index,
    required this.text,
  });

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                index.isEven ? Theme.of(context).primaryColor : Colors.red,
            child: Icon(
              index.isEven ? Icons.check : Icons.close,
              size: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 40,
                  color: AppColors.lightSecondary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReviewQuestionItem extends StatelessWidget {
  const ReviewQuestionItem({
    super.key,
    required this.text,
    required this.index,
  });
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryBlue,
        ),
        borderRadius: BorderRadius.circular(5),
        color: AppColors.secondaryColor,
      ),
      padding: const EdgeInsets.only(left: 60, right: 30, top: 30, bottom: 30),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Html(
                data: text,
                style: {
                  // tables will have the below background color
                  '*': Style(
                    color: Colors.white,
                    fontSize: const FontSize(25),
                  ),
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                    value: true,
                    toggleSize: 15,
                    height: 20,
                    width: 40,
                    activeColor: const Color(0xFF00abe0),
                    onToggle: (val) {},
                  ),
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: index.isEven
                        ? Theme.of(context).primaryColor
                        : Colors.red,
                    child: Icon(
                      index.isEven ? Icons.check : Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewGroupButtonItem extends StatelessWidget {
  const ReviewGroupButtonItem({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton(
        onPressed: () => print(text),
        style: TextButton.styleFrom(
          elevation: 0,
          side: BorderSide.none,
          backgroundColor: Colors.white,
          primary: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF969696),
            ),
          ),
        ),
      ),
    );
  }
}
