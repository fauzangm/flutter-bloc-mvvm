import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:mvvm_flutter/domain/repository/favorite/favoriteRepository.dart';

class InsertFavoriteItem {
  final FavoriteRepository favoriteRepository;

  InsertFavoriteItem(this.favoriteRepository);

  Future<Either<String, String>> execute(Data item) {
    return favoriteRepository.insertFavorite(item);
  }
}
