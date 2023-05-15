import 'package:dartz/dartz.dart';

import '../../data/remote/response/LoginResponse.dart';
import '../repository/auth/LoginRepository.dart';

class PostLoginUser {
  final LoginRepository loginRepository;

  PostLoginUser(this.loginRepository);

  Future<Either<String, Login>> execute(String email, String password) {
    return loginRepository.postLoginUser(email, password);
  }
}
