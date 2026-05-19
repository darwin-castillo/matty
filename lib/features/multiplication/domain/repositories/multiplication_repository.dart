import '../entities/multiplication_operation.dart';

abstract class MultiplicationRepository {
  MultiplicationOperation getRandomOperation(int tableNumber);
  bool checkAnswer(MultiplicationOperation operation, int selectedAnswer);
}