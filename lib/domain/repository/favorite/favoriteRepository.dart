import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';

abstract class FavoriteRepository {
  Future<Either<String, String>> insertFavorite(Data item);
  Future<Either<String, List<Data>>> getFavorite();
  Future<Either<String, String>> clearDatabase();
}
