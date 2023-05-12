import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mvvm_flutter/bloc/MultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/bloc/SingleUser/SingleUserBloc.dart';
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/getSingleUser.dart';
import 'package:mvvm_flutter/domain/usecase/getMultiUser.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  //BLOC
  locator.registerFactory(() => SingleUserBloc(locator()));
  locator.registerFactory(() => MultiUserBloc(locator()));

  //Use Case
  locator.registerLazySingleton(() => GetSingleUser(locator()));
  locator.registerLazySingleton(() => GetMultiUser(locator()));

  //Repository
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator(), locator()));

  //Service
  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl(locator()));
  locator.registerSingleton<Client>(http.Client());
}