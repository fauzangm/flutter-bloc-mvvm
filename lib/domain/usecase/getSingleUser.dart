import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/common/failure.dart';
import 'package:mvvm_flutter/data/remote/response/SingleUser.dart';
import 'package:mvvm_flutter/domain/repository/user/UserRepository.dart';

class GetSingleUser {
  final UserRepository repository;

  GetSingleUser(this.repository);

  Future<Either<String, SingleUser>> execute(int id) {
    return repository.getSingleUser(id);
  }
}
