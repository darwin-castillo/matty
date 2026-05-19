import 'package:equatable/equatable.dart';

class MultiplicationOperation extends Equatable {
  final int multiplicand;
  final int multiplier;
  final int correctAnswer;
  final List<int> allAnswers;

  const MultiplicationOperation({
    required this.multiplicand,
    required this.multiplier,
    required this.correctAnswer,
    required this.allAnswers,
  });

  String get questionText => '$multiplicand × $multiplier';

  @override
  List<Object> get props => [multiplicand, multiplier, correctAnswer, allAnswers];
}