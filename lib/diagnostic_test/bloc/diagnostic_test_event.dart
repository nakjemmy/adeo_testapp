part of 'diagnostic_test_bloc.dart';

abstract class DiagnosticTestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DiagnosticTestLoaded extends DiagnosticTestEvent {}

class DiagnosticTestCurrentQuestionChanged extends DiagnosticTestEvent {
  DiagnosticTestCurrentQuestionChanged({
    required this.index,
  });

  final int index;

  @override
  List<Object> get props => [index];
}

class DiagnosticTestNextQuestionRequested extends DiagnosticTestEvent {}

class ReviewtTopicsScorePercentageDisplayToggled extends DiagnosticTestEvent {}

class SelectedReviewQuestionsTypeChanged extends DiagnosticTestEvent {
  SelectedReviewQuestionsTypeChanged({
    required this.type,
  });

  final ReviewQuestionsFilterType type;

  @override
  List<Object> get props => [type];
}

class DiagnosticTestPreviousQuestionRequested extends DiagnosticTestEvent {}

class DiagnosticTestAnswerSelected extends DiagnosticTestEvent {
  DiagnosticTestAnswerSelected({
    required this.answer,
  });

  final Answer answer;

  @override
  List<Object> get props => [answer];
}
