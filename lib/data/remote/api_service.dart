import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/response/MultiUser.dart';
import 'package:mvvm_flutter/data/remote/response/SingleUser.dart';

import '../../common/exception.dart';

const baseUrl = 'https://reqres.in/api/';
const user = 'users';

abstract class ApiService {
  Future<SingleUser> getSingleUser(int id);
  Future<MultiUser> getMultiUser(int page);
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
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      var result = SingleUser.fromJson(data);
      print(result.data?.firstName);
      return SingleUser.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
