import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:mvvm_flutter/data/remote/response/LoginResponse.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/getMultiUser.dart';

import '../../../data/remote/response/MultiUser.dart';
import '../../../domain/usecase/postLoginUser.dart';
part 'LoginUserEvent.dart';
part 'LoginUserState.dart';

class FavoriteUserBloc extends Bloc<FavoriteUserEvent, FavoriteItemState> {
  final PostLoginUser postLoginUser;
  FavoriteUserBloc(this.postLoginUser) : super(LoginUserInitial()) {


  }


}
