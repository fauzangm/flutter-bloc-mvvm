import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/remote/api_service.dart';
import '../../remote/response/MultiUser.dart';
import '../../remote/response/SingleUser.dart';

class UserRepository {
  final http.Client client;

  UserRepository(this.client);

  Future<Either<String, MultiUser>> getMultiUserFromApi(int id) async {
    try {
      final response = await client.get(Uri.parse(baseUrl + user)
          .replace(queryParameters: {'page': id.toString()}));
      Map<String, dynamic> data = (json.decode(response.body));
      return Right(MultiUser.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SingleUser>> getSingleUserFromApi(int id) async {
    try {
      final response = await client.get(Uri.parse("$baseUrl$user/$id"));
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      return Right(SingleUser.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
