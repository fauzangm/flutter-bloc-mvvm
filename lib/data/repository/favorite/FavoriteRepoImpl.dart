import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/local/local_data_source.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:mvvm_flutter/domain/repository/favorite/favoriteRepository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final LocalDataSource _local;

  FavoriteRepositoryImpl(this._local);

  @override
  Future<Either<String, List<Data>>> getFavorite() async {
    try {
      List<Data> result = await _local.getFavoriteItem();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> insertFavorite(Data item) async {
    try {
      _local.insertFavoriteItem(item);
      return Right("Berhasil Save Favorite $item");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
