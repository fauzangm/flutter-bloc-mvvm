import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/response/MultiUser.dart';
import 'package:mvvm_flutter/data/response/SingleUser.dart';

class ApiService {
  final http.Client client;
  ApiService({
    required this.client,
  });

  Future<Either<String, MultiUser>> getMultiUserFromApi(int id) async {
    try {
      final response = await client
          .get(Uri.parse("https://reqres.in/api/users?page=" + id.toString()));
      Map<String, dynamic> data = (json.decode(response.body));
      return Right(MultiUser.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
    // Uri apiURL = Uri.parse("https://reqres.in/api/users?page=" + id.toString());
    // var apiResult = await http.get(apiURL);
    // Map<String, dynamic> jsonObject = json.decode(apiResult.body);
    // var resultData = MultiUser.fromJson(jsonObject);
  }

  Future<Either<String, SingleUser>> getSingleUserFromApi(int id) async {
    try {
      final response = await client
          .get(Uri.parse("https://reqres.in/api/users/" + id.toString()));
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      return Right(SingleUser.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
    // Uri apiURL = Uri.parse("https://reqres.in/api/users/" + id.toString());
    // var apiResult = await http.get(apiURL);
    // var jsonObject = json.decode(apiResult.body);
    // Map<String, dynamic> data =
    //     (json.decode(apiResult.body) as Map<String, dynamic>);

    // var resultData = SingleUser.fromJson(data);
    // return SingleUser.fromJson(data);
  }
}
