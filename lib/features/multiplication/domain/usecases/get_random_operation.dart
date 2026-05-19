import '../../../../core/usecases/usecase.dart';
import '../entities/multiplication_operation.dart';
import '../repositories/multiplication_repository.dart';

class GetRandomOperation implements UseCase<MultiplicationOperation, int> {
  final MultiplicationRepository repository;

  GetRandomOperation(this.repository);

  @override
  MultiplicationOperation call(int tableNumber) {
    return repository.getRandomOperation(tableNumber);
  }
}