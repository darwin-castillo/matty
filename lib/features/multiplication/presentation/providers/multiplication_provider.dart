import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/multiplication_repository_impl.dart';
import '../../domain/entities/multiplication_operation.dart';
import '../../domain/repositories/multiplication_repository.dart';
import '../../domain/usecases/check_answer.dart';
import '../../domain/usecases/get_random_operation.dart';

final multiplicationRepositoryProvider = Provider<MultiplicationRepository>((ref) {
  return MultiplicationRepositoryImpl();
});

final getRandomOperationUseCaseProvider = Provider<GetRandomOperation>((ref) {
  return GetRandomOperation(ref.watch(multiplicationRepositoryProvider));
});

final checkAnswerUseCaseProvider = Provider<CheckAnswer>((ref) {
  return CheckAnswer(ref.watch(multiplicationRepositoryProvider));
});

class MultiplicationState {
  final MultiplicationOperation? currentOperation;
  final int? selectedAnswer;
  final bool? isCorrect;
  final int correctCount;
  final int incorrectCount;
  final int tableNumber;

  const MultiplicationState({
    this.currentOperation,
    this.selectedAnswer,
    this.isCorrect,
    this.correctCount = 0,
    this.incorrectCount = 0,
    this.tableNumber = 2,
  });

  MultiplicationState copyWith({
    MultiplicationOperation? currentOperation,
    int? selectedAnswer,
    bool? isCorrect,
    int? correctCount,
    int? incorrectCount,
    int? tableNumber,
  }) {
    return MultiplicationState(
      currentOperation: currentOperation ?? this.currentOperation,
      selectedAnswer: selectedAnswer,
      isCorrect: isCorrect,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      tableNumber: tableNumber ?? this.tableNumber,
    );
  }
}

class MultiplicationNotifier extends StateNotifier<MultiplicationState> {
  final GetRandomOperation _getRandomOperation;
  final CheckAnswer _checkAnswer;

  MultiplicationNotifier(this._getRandomOperation, this._checkAnswer)
      : super(const MultiplicationState()) {
    generateNewOperation();
  }

  void generateNewOperation() {
    final operation = _getRandomOperation(state.tableNumber);
    state = state.copyWith(
      currentOperation: operation,
      selectedAnswer: null,
      isCorrect: null,
    );
  }

  void selectAnswer(int answer) {
    if (state.selectedAnswer != null) return;

    final isCorrect = _checkAnswer(CheckAnswerParams(
      operation: state.currentOperation!,
      selectedAnswer: answer,
    ));

    state = state.copyWith(
      selectedAnswer: answer,
      isCorrect: isCorrect,
      correctCount: isCorrect ? state.correctCount + 1 : state.correctCount,
      incorrectCount: !isCorrect ? state.incorrectCount + 1 : state.incorrectCount,
    );
  }

  void nextQuestion() {
    generateNewOperation();
  }
}

final multiplicationProvider =
    StateNotifierProvider<MultiplicationNotifier, MultiplicationState>((ref) {
  return MultiplicationNotifier(
    ref.watch(getRandomOperationUseCaseProvider),
    ref.watch(checkAnswerUseCaseProvider),
  );
});