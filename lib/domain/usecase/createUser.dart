import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/response/CreateAkunResponse.dart';
import 'package:mvvm_flutter/domain/repository/user/UserRepository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase(this.repository);

  Future<Either<String, CreateUser>> execute(String name, String job) {
    return repository.createUser(name, job);
  }
}
