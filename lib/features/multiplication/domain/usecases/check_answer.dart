import '../../../../core/usecases/usecase.dart';
import '../entities/multiplication_operation.dart';
import '../repositories/multiplication_repository.dart';

class CheckAnswerParams {
  final MultiplicationOperation operation;
  final int selectedAnswer;

  CheckAnswerParams({required this.operation, required this.selectedAnswer});
}

class CheckAnswer implements UseCase<bool, CheckAnswerParams> {
  final MultiplicationRepository repository;

  CheckAnswer(this.repository);

  @override
  bool call(CheckAnswerParams params) {
    return repository.checkAnswer(params.operation, params.selectedAnswer);
  }
}