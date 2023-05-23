import 'package:dartz/dartz.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:mvvm_flutter/domain/repository/favorite/favoriteRepository.dart';

class GetFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  GetFavoriteUseCase(this.favoriteRepository);

  Future<Either<String, List<Data>>> execute() {
    return favoriteRepository.getFavorite();
  }
}
