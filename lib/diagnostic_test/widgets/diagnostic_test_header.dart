// ignore_for_file: avoid_unnecessary_containers

import 'package:adeo_testapp/diagnostic_test/bloc/diagnostic_test_bloc.dart';
import 'package:adeo_testapp/diagnostic_test/bloc/timer_bloc.dart';
import 'package:adeo_testapp/helpers.dart';
import 'package:adeo_testapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DiagnosticTestHeader extends StatelessWidget {
  const DiagnosticTestHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: double.maxFinite,
        child: Stack(
          children: [
            SizedBox(
              width: 400,
              child: BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
                  builder: (context, state) {
                return QuestionNumbers();
              }),
            ),
            Positioned(
              top: 0,
              right: -10,
              child: Stack(
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/header_right.png'),
                  ),
                  Positioned(
                    right: 25,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              'You pressed skip',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        child: BlocBuilder<TimerBloc, TimerState>(
                          builder: (context, state) {
                            return const TimerText();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final timerString = getTimerString(duration);

    return Text(
      timerString,
      style: const TextStyle(
        color: AppColors.primaryColor,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class QuestionNumbers extends StatelessWidget {
  QuestionNumbers({
    super.key,
  });

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      child: BlocListener<DiagnosticTestBloc, DiagnosticTestState>(
        listener: (context, state) {
          final isCurrentlyVisible = itemPositionsListener.itemPositions.value
              .toList()
              .where((e) => e.index == state.currentQuestionIndex)
              .isNotEmpty;
          if (!isCurrentlyVisible) {
            itemScrollController.scrollTo(
              index: state.currentQuestionIndex,
              duration: const Duration(milliseconds: 500),
            );
          }
        },
        child: BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
          builder: (context, state) {
            return ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              initialScrollIndex: state.currentQuestionIndex,
              itemCount: state.questions.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final selected = index == state.currentQuestionIndex;
                return InkWell(
                  onTap: () {
                    context.read<DiagnosticTestBloc>().add(
                          DiagnosticTestCurrentQuestionChanged(
                            index: index,
                          ),
                        );
                  },
                  child: SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.white54,
                            fontSize: 40,
                          ),
                        ),
                        if (selected)
                          Container(
                            width: 40,
                            height: 5,
                            color: Colors.white,
                          )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
