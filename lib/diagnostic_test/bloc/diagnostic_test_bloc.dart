import 'dart:async';
import 'package:adeo_testapp/diagnostic_test/models/answer.dart';
import 'package:adeo_testapp/diagnostic_test/models/question.dart';
import 'package:adeo_testapp/diagnostic_test/repositories/diagnostic_test_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'diagnostic_test_event.dart';
part 'diagnostic_test_state.dart';

class DiagnosticTestBloc
    extends Bloc<DiagnosticTestEvent, DiagnosticTestState> {
  DiagnosticTestBloc({required this.diagnosticTestRepository})
      : super(const DiagnosticTestState()) {
    // on<DiagnosticTestLoadingRequested>(_onDiagnosticTestLoadingRequested);
    on<DiagnosticTestLoaded>(_onDiagnosticTestLoaded);
    on<DiagnosticTestCurrentQuestionChanged>(
      _onDiagnosticTestCurrentQuestionChanged,
    );
    on<DiagnosticTestNextQuestionRequested>(
      _onDiagnosticTestNextQuestionRequested,
      // transformer: debounce(const Duration(milliseconds: 2000)),
    );
    on<DiagnosticTestPreviousQuestionRequested>(
      _onDiagnosticTestPreviousQuestionRequested,
    );
    on<DiagnosticTestAnswerSelected>(
      _onDiagnosticTestAnswerSelected,
    );
    on<ReviewtTopicsScorePercentageDisplayToggled>(
      _onReviewtTopicsScorePercentageDisplayToggled,
    );
    on<SelectedReviewQuestionsTypeChanged>(
      _onSelectedReviewQuestionsTypeChanged,
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  final DiagnosticTestRepository diagnosticTestRepository;

  Future<void> _onDiagnosticTestLoaded(
    DiagnosticTestLoaded event,
    Emitter<DiagnosticTestState> emit,
  ) async {
    try {
      final questions = await diagnosticTestRepository.getQuestions(limit: 5);

      emit(
        state.copyWith(
          status: DiagnosticTestStatus.success,
          questions: questions,
        ),
      );
    } catch (e, s) {
      addError(e, s);
      emit(
        state.copyWith(
          status: DiagnosticTestStatus.failure,
          questions: [],
          errorMessage: 'Failed to load test, Please try again.',
        ),
      );
    }
  }

  void _onDiagnosticTestCurrentQuestionChanged(
    DiagnosticTestCurrentQuestionChanged event,
    Emitter<DiagnosticTestState> emit,
  ) {
    emit(
      state.copyWith(
        currentQuestionIndex: event.index,
      ),
    );
  }

  void _onDiagnosticTestNextQuestionRequested(
    DiagnosticTestNextQuestionRequested event,
    Emitter<DiagnosticTestState> emit,
  ) {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(
        state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex + 1,
        ),
      );
    }
  }

  void _onDiagnosticTestPreviousQuestionRequested(
    DiagnosticTestPreviousQuestionRequested event,
    Emitter<DiagnosticTestState> emit,
  ) {
    if (state.currentQuestionIndex > 0) {
      emit(
        state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex - 1,
        ),
      );
    }
  }

  void _onDiagnosticTestAnswerSelected(
    DiagnosticTestAnswerSelected event,
    Emitter<DiagnosticTestState> emit,
  ) {
    final newChosenAnswers = {...state.chosenAnswers};
    newChosenAnswers[event.answer.questionId] = event.answer.id;
    emit(
      state.copyWith(
        chosenAnswers: newChosenAnswers,
      ),
    );
  }

  void _onReviewtTopicsScorePercentageDisplayToggled(
      ReviewtTopicsScorePercentageDisplayToggled event,
      Emitter<DiagnosticTestState> emit) {
    emit(
      state.copyWith(
        showTopicScoreAsPercentage: !state.showTopicScoreAsPercentage,
      ),
    );
  }

  void _onSelectedReviewQuestionsTypeChanged(
      SelectedReviewQuestionsTypeChanged event,
      Emitter<DiagnosticTestState> emit) {
    emit(
      state.copyWith(
        reviewQuestionFilterType: event.type,
      ),
    );
  }
}
