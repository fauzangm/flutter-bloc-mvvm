import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mvvm_flutter/data/repository/favorite/FavoriteRepoImpl.dart';
import 'package:mvvm_flutter/domain/repository/auth/LoginRepository.dart';
import 'package:mvvm_flutter/domain/repository/favorite/favoriteRepository.dart';
import 'package:mvvm_flutter/domain/usecase/clearDatabaseFavorite.dart';
import 'package:mvvm_flutter/domain/usecase/createUser.dart';
import 'package:mvvm_flutter/domain/usecase/postLoginUser.dart';
import 'package:mvvm_flutter/ui/bloc/CreateUser/CreateUserBloc.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/FavoriteBloc.dart';
import 'package:mvvm_flutter/ui/bloc/LoginUser/LoginUserBloc.dart';
import 'package:mvvm_flutter/ui/bloc/MultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/ui/bloc/SingleUser/SingleUserBloc.dart';
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/getSingleUser.dart';
import 'package:mvvm_flutter/domain/usecase/getMultiUser.dart';
import 'package:http/http.dart' as http;

import '../data/local/database_helper.dart';
import '../data/local/local_data_source.dart';
import '../data/repository/auth/LoginRepositoryImpl.dart';
import '../domain/usecase/insertFavoritemItem.dart';

final locator = GetIt.instance;

void init() {
  //BLOC
  locator.registerFactory(() => SingleUserBloc(locator()));
  locator.registerFactory(() => MultiUserBloc(locator()));
  locator.registerFactory(() => LoginUserBloc(locator()));
  locator.registerFactory(() => FavoriteUserBloc(locator(), locator()));
  locator.registerFactory(() => CreateUserBloc(locator()));

  //Use Case
  locator.registerLazySingleton(() => GetSingleUser(locator()));
  locator.registerLazySingleton(() => GetMultiUser(locator()));
  locator.registerLazySingleton(() => PostLoginUser(locator()));
  locator.registerLazySingleton(() => CreateUserUseCase(locator()));
  locator.registerLazySingleton(() => InsertFavoriteItem(locator()));
  locator.registerLazySingleton(() => ClearDBFavoriteUseCase(locator()));

  //Repository
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator(), locator()));

  locator.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(locator()));

  //Service
  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl(locator()));
  locator.registerSingleton<Client>(http.Client());

  //Data Sources
  locator
      .registerLazySingleton<LocalDataSource>(() => LocalDataSource(locator()));
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
