import 'dart:math';
import '../../domain/entities/multiplication_operation.dart';
import '../../domain/repositories/multiplication_repository.dart';

class MultiplicationRepositoryImpl implements MultiplicationRepository {
  final Random _random = Random();

  @override
  MultiplicationOperation getRandomOperation(int tableNumber) {
    final multiplier = _random.nextInt(9) + 1;
    final correctAnswer = tableNumber * multiplier;

    final allAnswers = _generateAnswers(correctAnswer, tableNumber);

    return MultiplicationOperation(
      multiplicand: tableNumber,
      multiplier: multiplier,
      correctAnswer: correctAnswer,
      allAnswers: allAnswers,
    );
  }

  List<int> _generateAnswers(int correctAnswer, int tableNumber) {
    final answers = <int>{correctAnswer};

    while (answers.length < 4) {
      final wrongAnswer = correctAnswer + _random.nextInt(5) - 2;
      if (wrongAnswer > 0 && wrongAnswer != correctAnswer) {
        answers.add(wrongAnswer);
      }
    }

    final answersList = answers.toList();
    answersList.shuffle(_random);
    return answersList;
  }

  @override
  bool checkAnswer(MultiplicationOperation operation, int selectedAnswer) {
    return operation.correctAnswer == selectedAnswer;
  }
}