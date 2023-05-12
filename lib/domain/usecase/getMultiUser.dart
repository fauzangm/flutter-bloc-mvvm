import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/response/MultiUser.dart';

import '../repository/user/UserRepository.dart';

class GetMultiUser {
  final UserRepository repository;

  GetMultiUser(this.repository);

  Future<Either<String, MultiUser>> execute(int page) {
    return repository.getMultiUser(page);
  }
}
