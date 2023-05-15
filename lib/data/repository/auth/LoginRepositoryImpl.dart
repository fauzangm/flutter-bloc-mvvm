import 'package:mvvm_flutter/data/remote/response/LoginResponse.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/domain/repository/auth/LoginRepository.dart';
import 'package:http/http.dart' as http;

import '../../remote/api_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  final http.Client client;
  final ApiService apiService;

  LoginRepositoryImpl(this.client, this.apiService);
  @override
  Future<Either<String, Login>> postLoginUser(
      String email, String password) async {
    try {
      final result = apiService.postLoginUser(email, password);
      var data = await result;
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
