part of 'diagnostic_test_bloc.dart';

enum DiagnosticTestStatus { initial, success, failure }

enum ReviewQuestionsFilterType {
  all,
  correctlyAnswered,
  wronglyAnswered,
  notAttempted,
}

class DiagnosticTestState extends Equatable {
  const DiagnosticTestState({
    this.status = DiagnosticTestStatus.initial,
    this.questions = const <Question>[],
    this.errorMessage,
    this.currentQuestionIndex = 0,
    this.chosenAnswers = const {},
    this.reviewQuestionFilterType = ReviewQuestionsFilterType.all,
    this.showTopicScoreAsPercentage = false,
    this.testTime = 10,
  });

  final DiagnosticTestStatus status;
  final List<Question> questions;
  final String? errorMessage;
  final int currentQuestionIndex;
  final Map<int, int> chosenAnswers;
  final ReviewQuestionsFilterType reviewQuestionFilterType;
  final bool showTopicScoreAsPercentage;
  final int testTime;

  DiagnosticTestState copyWith({
    DiagnosticTestStatus? status,
    List<Question>? questions,
    String? errorMessage,
    int? currentQuestionIndex,
    Map<int, int>? chosenAnswers,
    ReviewQuestionsFilterType? reviewQuestionFilterType,
    bool? showTopicScoreAsPercentage,
  }) {
    return DiagnosticTestState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      chosenAnswers: chosenAnswers ?? this.chosenAnswers,
      reviewQuestionFilterType:
          reviewQuestionFilterType ?? this.reviewQuestionFilterType,
      showTopicScoreAsPercentage:
          showTopicScoreAsPercentage ?? this.showTopicScoreAsPercentage,
    );
  }

  List<Question> get answeredQuestions {
    return chosenAnswers.keys.map((i) {
      return questions.firstWhere((e) => e.id == i);
    }).toList();
  }

  List<Question> get unAnsweredQuestions {
    return questions
        .where(
          (question) => answeredQuestions
              .every((answeredQuestion) => answeredQuestion.id != question.id),
        )
        .toList();
  }

  List<Answer> get allAnswers {
    return questions.expand((question) => question.answers).toList();
  }

  List<Question> get correctlyAnsweredQuestions {
    return answeredQuestionFilter((answer) => answer.isRightAnswer);
  }

  List<Question> get wronglyAnsweredQuestions {
    return answeredQuestionFilter((answer) => !answer.isRightAnswer);
  }

  List<Question> answeredQuestionFilter(bool Function(Answer) filterer) {
    return chosenAnswers.values
        .map((i) {
          return allAnswers.firstWhere((e) => e.id == i);
        }) // First get all answers as Answer models
        .where(filterer) // Filter for right answer
        .map(
          (e) =>
              questions.firstWhere((question) => question.id == e.questionId),
        ) // Transform to get corresponding questions
        .toList();
  }

  List<Question> get currentFilteredQuestions {
    switch (reviewQuestionFilterType) {
      case ReviewQuestionsFilterType.all:
        return questions;
      case ReviewQuestionsFilterType.correctlyAnswered:
        return correctlyAnsweredQuestions;
      case ReviewQuestionsFilterType.wronglyAnswered:
        return wronglyAnsweredQuestions;
      case ReviewQuestionsFilterType.notAttempted:
        return unAnsweredQuestions;
    }
  }

  int get score => correctlyAnsweredQuestions.length;

  int get totalQuestions => questions.length;

  @override
  List<Object?> get props => [
        status,
        questions,
        errorMessage,
        currentQuestionIndex,
        chosenAnswers,
        reviewQuestionFilterType,
        showTopicScoreAsPercentage,
      ];
}
