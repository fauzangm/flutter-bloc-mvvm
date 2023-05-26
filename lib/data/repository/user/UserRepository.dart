import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/local/local_data_source.dart';
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/remote/response/CreateAkunResponse.dart';
import 'package:mvvm_flutter/domain/repository/user/UserRepository.dart';
import '../../../common/failure.dart';
import '../../remote/model/DataUser.dart';
import '../../remote/response/MultiUser.dart';
import '../../remote/response/SingleUser.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource _local;
  final http.Client client;
  final ApiService apiService;
  UserRepositoryImpl(this.client, this.apiService, this._local);

  @override
  Future<Either<String, MultiUser>> getMultiUser(int page) async {
    try {
      final result = apiService.getMultiUser(page);
      var data = await result;

      List<Data> localdb = await _local.getFavoriteItem();
      localdb.forEach(
        (element) {
          data.data!.forEach((item) {
            if (item.email == element.email) {
              item.isFavorite = true;
            }
          });
        },
      );
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, SingleUser>> getSingleUser(int id) async {
    try {
      final result = apiService.getSingleUser(id);
      var data = await result;
      List<Data> localdb = await _local.getFavoriteItem();
      localdb.forEach(
        (element) {
          if (data.data!.email == element.email) {
            data.data!.isFavorite = true;
            print(data.data!.isFavorite);
          }
        },
      );
      print(data.data!.isFavorite);
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CreateUser>> createUser(String name, String job) async {
    try {
      final result = apiService.postCreatUser(name, job);
      var data = await result;
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Future<Either<String, MultiUser>> getMultiUserFromApi(int id) async {
  //   try {
  //     final response = await client.get(Uri.parse(baseUrl + user)
  //         .replace(queryParameters: {'page': id.toString()}));
  //     Map<String, dynamic> data = (json.decode(response.body));
  //     return Right(MultiUser.fromJson(data));
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }

  // Future<Either<String, SingleUser>> getSingleUserFromApi(int id) async {
  //   try {
  //     final response = await client.get(Uri.parse("$baseUrl$user/$id"));
  //     Map<String, dynamic> data =
  //         (json.decode(response.body) as Map<String, dynamic>);
  //     return Right(SingleUser.fromJson(data));
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
