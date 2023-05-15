import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/remote/response/LoginResponse.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/getMultiUser.dart';

import '../../../data/remote/response/MultiUser.dart';
import '../../../domain/usecase/postLoginUser.dart';
part 'LoginUserEvent.dart';
part 'LoginUserState.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final PostLoginUser postLoginUser;
  LoginUserBloc(this.postLoginUser) : super(LoginUserInitial()) {
    on<LoginEventClick>(_onLoginEventLoginClick);
    on<PostLoginUserEvent>(_postLoginUserEvent);
  }

  Future<void> _onLoginEventLoginClick(
      LoginEventClick event, Emitter<LoginUserState> emit) async {
    emit(const LoginStateClicked());
    emit(LoginUserInitial());
  }

  Future<void> _postLoginUserEvent(
      PostLoginUserEvent event, Emitter<LoginUserState> emit) async {
    emit(LoginUserLoading());
    var resultData = await postLoginUser.execute(event.email, event.password);
    resultData.fold(
        (l) => emit(LoginUserError(l)), (r) => emit(LoginUserSucces(user: r)));
  }
}
