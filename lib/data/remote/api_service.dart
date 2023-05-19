import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/response/CreateAkunResponse.dart';
import 'package:mvvm_flutter/data/remote/response/LoginResponse.dart';
import 'package:mvvm_flutter/data/remote/response/MultiUser.dart';
import 'package:mvvm_flutter/data/remote/response/SingleUser.dart';

import '../../common/exception.dart';

const baseUrl = 'https://reqres.in/api/';
const user = 'users';
const login = 'login';

abstract class ApiService {
  Future<SingleUser> getSingleUser(int id);
  Future<MultiUser> getMultiUser(int page);
  Future<Login> postLoginUser(String email, String password);
  Future<CreateUser> postCreatUser(String name, String job);
}

class ApiServiceImpl implements ApiService {
  final http.Client client;

  ApiServiceImpl(this.client);
  @override
  Future<MultiUser> getMultiUser(int page) async {
    final response = await client.get(Uri.parse(baseUrl + user)
        .replace(queryParameters: {'page': page.toString()}));
    if (response.statusCode == 200) {
      // Map<String, dynamic> data = (json.decode(response.body));
      return MultiUser.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SingleUser> getSingleUser(int id) async {
    final response = await client.get(Uri.parse("$baseUrl$user/$id"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      return SingleUser.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Login> postLoginUser(String email, String password) async {
    final response = await client.post(
      Uri.parse("$baseUrl$login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Login.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CreateUser> postCreatUser(String name, String job) async {
    final response = await client.post(
      Uri.parse("$baseUrl$user"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return CreateUser.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
