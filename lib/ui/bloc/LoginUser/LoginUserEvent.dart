part of 'LoginUserBloc.dart';

abstract class LoginUserEvent {}

class PostLoginUserEvent extends LoginUserEvent {
  final String email;
  final String password;
  PostLoginUserEvent(this.password, {required this.email});
}

class LoginEventClick extends LoginUserEvent {}
