// ignore_for_file: avoid_unnecessary_containers

import 'package:adeo_testapp/diagnostic_test/bloc/diagnostic_test_bloc.dart';
import 'package:adeo_testapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiagnosticTestReviewSectionsHeader extends StatelessWidget {
  const DiagnosticTestReviewSectionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      const _HeaderItem(
        text: 'All',
        type: ReviewQuestionsFilterType.all,
      ),
      _HeaderItem(
        text: 'Correctly Answered',
        type: ReviewQuestionsFilterType.correctlyAnswered,
        leading: CircleAvatar(
          radius: 15,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.check,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      const _HeaderItem(
        text: 'Wrongly Answered',
        type: ReviewQuestionsFilterType.wronglyAnswered,
        leading: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.red,
          child: Icon(
            Icons.close,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      const _HeaderItem(
        text: 'Not Attempted',
        type: ReviewQuestionsFilterType.notAttempted,
        leading: CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.lightSecondary,
          child: Icon(
            Icons.question_mark,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: BlocBuilder<DiagnosticTestBloc, DiagnosticTestState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...data.map((item) {
                return InkWell(
                  onTap: () {
                    context.read<DiagnosticTestBloc>().add(
                          SelectedReviewQuestionsTypeChanged(type: item.type),
                        );
                  },
                  child: Container(
                    width: 140,
                    height: 70,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              item.leading ?? Container(),
                              Expanded(
                                child: Text(
                                  item.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (state.reviewQuestionFilterType == item.type)
                          Container(
                            width: 140,
                            height: 5,
                            color: Colors.white,
                          )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderItem {
  const _HeaderItem({
    required this.text,
    required this.type,
    this.leading,
  });

  final String text;
  final ReviewQuestionsFilterType type;
  final Widget? leading;
}
