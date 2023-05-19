part of 'CreateUserBloc.dart';

abstract class CreateUserEvent {}

class PostCreateUserEvent extends CreateUserEvent {
  final String name;
  final String job;

  PostCreateUserEvent(this.name, this.job);
}

class CreateEventClick extends CreateUserEvent {}
