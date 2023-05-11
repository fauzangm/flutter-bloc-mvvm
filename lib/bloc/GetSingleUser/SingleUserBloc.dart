import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import '../../data/api_service.dart';
import '../../data/response/SingleUser.dart';
part 'SingleUserEvent.dart';
part 'SingleUserState.dart';

class SingleUserBloc extends Bloc<SingleUserEvent, SingleUserState> {
  final ApiService apiService;
  SingleUserBloc(this.apiService) : super(SingleUserInitial()) {
    on<GetSingleUserEvent>((event, emit) async {
      emit(SingleUserLoading());
      final resultData = await apiService.getSingleUserFromApi(event.idUser);
      resultData.fold((l) => emit(SingleUserError(l)),
          (r) => emit(SingleUserSucces(user: r)));
    });
  }
}
