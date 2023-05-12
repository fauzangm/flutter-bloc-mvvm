import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/getMultiUser.dart';

import '../../../data/remote/response/MultiUser.dart';
part 'MultiUserEvent.dart';
part 'MultiUserState.dart';

class MultiUserBloc extends Bloc<MultiUserEvent, MultiUserState> {
  final GetMultiUser getMultiUser;
  MultiUserBloc(this.getMultiUser) : super(MultiUserInitial()) {
    on<GetMultiUserEvent>((event, emit) async {
      emit(MultiUserLoading());
      var resultData = await getMultiUser.execute(event.idpage);
      resultData.fold((l) => emit(MultiUserError(l)),
          (r) => emit(MultiUserSucces(user: r)));
    });
  }
}
