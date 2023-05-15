import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mvvm_flutter/domain/repository/auth/LoginRepository.dart';
import 'package:mvvm_flutter/domain/usecase/postLoginUser.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/Favorite_bloc.dart';
import 'package:mvvm_flutter/ui/bloc/LoginUser/LoginUserBloc.dart';
import 'package:mvvm_flutter/ui/bloc/MultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/ui/bloc/SingleUser/SingleUserBloc.dart';
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/getSingleUser.dart';
import 'package:mvvm_flutter/domain/usecase/getMultiUser.dart';
import 'package:http/http.dart' as http;

import '../data/repository/auth/LoginRepositoryImpl.dart';

final locator = GetIt.instance;

void init() {
  //BLOC
  locator.registerFactory(() => SingleUserBloc(locator()));
  locator.registerFactory(() => MultiUserBloc(locator()));
  locator.registerFactory(() => LoginUserBloc(locator()));
  locator.registerFactory(() => FavoriteBloc());

  //Use Case
  locator.registerLazySingleton(() => GetSingleUser(locator()));
  locator.registerLazySingleton(() => GetMultiUser(locator()));
  locator.registerLazySingleton(() => PostLoginUser(locator()));

  //Repository
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator(), locator()));

  locator.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(locator(), locator()));

  //Service
  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl(locator()));
  locator.registerSingleton<Client>(http.Client());
}
