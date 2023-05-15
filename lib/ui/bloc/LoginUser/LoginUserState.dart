part of 'LoginUserBloc.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();
  @override
  List<Object> get props => [];
}

class LoginUserInitial extends LoginUserState {}

class LoginStateClicked extends LoginUserState {
  const LoginStateClicked() : super();
}

class LoginUserLoading extends LoginUserState {}

class LoginUserSucces extends LoginUserState {
  final Login user;

  LoginUserSucces({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginUserError extends LoginUserState {
  final String message;

  LoginUserError(this.message);

  @override
  List<Object> get props => [message];
}
