import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
  
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class ValidationFailure extends Failure {
  const ValidationFailure();
}