import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/response/SingleUser.dart';
part 'SingleUserEvent.dart';
part 'SingleUserState.dart';

class SingleUserBloc extends Bloc<SingleUserEvent, SingleUserState> {
  SingleUserBloc() : super(SingleUserInitial()) {
    on<GetSingleUserEvent>((event, emit) async {
      emit(SingleUserLoading());
      final response = await http.get(
          Uri.parse("https://reqres.in/api/users/" + event.idUser.toString()));
      var jsonObject = json.decode(response.body);
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      var resultData = SingleUser.fromJson(data);
      emit(SingleUserSucces(user: resultData));
    });
  }
}
