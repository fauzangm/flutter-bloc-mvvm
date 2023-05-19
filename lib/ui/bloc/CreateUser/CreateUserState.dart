part of 'CreateUserBloc.dart';

abstract class CreateUserState extends Equatable {
  const CreateUserState();
  @override
  List<Object> get props => [];
}

class CreateSteteInitial extends CreateUserState {}

class CreateStateClicked extends CreateUserState {
  const CreateStateClicked() : super();
}

class CreateUserLoading extends CreateUserState {}

class CreateUserSucces extends CreateUserState {
  final CreateUser data;

  const CreateUserSucces({required this.data});

  @override
  List<Object> get props => [data];
}

class CreateUserError extends CreateUserState {
  final String message;

  const CreateUserError(this.message);

  @override
  List<Object> get props => [message];
}
