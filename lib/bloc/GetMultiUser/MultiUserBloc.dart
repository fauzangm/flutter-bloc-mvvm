import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/api_service.dart';

import '../../data/response/MultiUser.dart';
part 'MultiUserEvent.dart';
part 'MultiUserState.dart';

class MultiUserBloc extends Bloc<MultiUserEvent, MultiUserState> {
  final ApiService apiService;
  MultiUserBloc(this.apiService) : super(MultiUserInitial()) {
    on<GetMultiUserEvent>((event, emit) async {
      emit(MultiUserLoading());
      var resultData = await apiService.getMultiUserFromApi(event.idpage);
      resultData.fold((l) => emit(MultiUserError(l)),
          (r) => emit(MultiUserSucces(user: r)));
    });
  }
}
