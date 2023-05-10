import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/response/MultiUser.dart';
part 'MultiUserEvent.dart';
part 'MultiUserState.dart';

class MultiUserBloc extends Bloc<MultiUserEvent, MultiUserState> {
  MultiUserBloc() : super(MultiUserInitial()) {
    on<GetMultiUserEvent>((event, emit) async {
      emit(MultiUserLoading());
      final response = await http.get(Uri.parse(
          "https://reqres.in/api/users?page=" + event.idpage.toString()));
      Map<String, dynamic> jsonObject = json.decode(response.body);
      var resultData = MultiUser.fromJson(jsonObject);
      emit(MultiUserSucces(user: resultData));
    });
  }
}
