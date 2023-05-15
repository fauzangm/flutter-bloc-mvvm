import 'package:dartz/dartz.dart';

import '../../../data/remote/response/LoginResponse.dart';

abstract class LoginRepository {
  Future<Either<String, Login>> postLoginUser(String email, String password);
}
