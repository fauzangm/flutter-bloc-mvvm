import 'package:dartz/dartz.dart';

import '../repository/favorite/favoriteRepository.dart';

class ClearDBFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  ClearDBFavoriteUseCase(this.favoriteRepository);

  Future<Either<String, String>> execute() {
    return favoriteRepository.clearDatabase();
  }
}
