import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/response/MultiUser.dart';
import '../../../data/remote/response/SingleUser.dart';

abstract class UserRepository {
  Future<Either<String, SingleUser>> getSingleUser(int id);
  Future<Either<String, MultiUser>> getMultiUser(int page);
}
