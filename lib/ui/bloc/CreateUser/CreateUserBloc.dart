import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/data/remote/response/CreateAkunResponse.dart';
import 'package:mvvm_flutter/domain/usecase/createUser.dart';

part 'CreateUserEvent.dart';
part 'CreateUserState.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final CreateUserUseCase postCreateUser;
  CreateUserBloc(this.postCreateUser) : super(CreateSteteInitial()) {
    on<CreateEventClick>(_onCreateEventLoginClick);
    on<PostCreateUserEvent>(_postCreateUserEvent);
  }

  Future<void> _onCreateEventLoginClick(
      CreateEventClick event, Emitter<CreateUserState> emit) async {
    emit(const CreateStateClicked());
    emit(CreateSteteInitial());
  }

  Future<void> _postCreateUserEvent(
      PostCreateUserEvent event, Emitter<CreateUserState> emit) async {
    emit(CreateUserLoading());
    var resultData = await postCreateUser.execute(event.name, event.job);
    resultData.fold((l) => emit(CreateUserError(l)),
        (r) => emit(CreateUserSucces(data: r)));
  }
}
