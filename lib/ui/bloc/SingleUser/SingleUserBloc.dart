import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/getSingleUser.dart';
import '../../../data/remote/api_service.dart';
import '../../../data/remote/response/SingleUser.dart';
part 'SingleUserEvent.dart';
part 'SingleUserState.dart';

class SingleUserBloc extends Bloc<SingleUserEvent, SingleUserState> {
  final GetSingleUser getSingleUser;
  SingleUserBloc(this.getSingleUser) : super(SingleUserInitial()) {
    on<GetSingleUserEvent>((event, emit) async {
      emit(SingleUserLoading());
      final resultData = await getSingleUser.execute(event.idUser);
      resultData.fold((l) => emit(SingleUserError(l)),
          (r) => emit(SingleUserSucces(user: r)));
    });
  }
}
