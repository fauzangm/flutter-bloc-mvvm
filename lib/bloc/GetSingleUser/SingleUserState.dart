part of 'SingleUserBloc.dart';

abstract class SingleUserState {}

class SingleUserInitial extends SingleUserState {}

class SingleUserLoading extends SingleUserState {}

class SingleUserSucces extends SingleUserState {
  final SingleUser user;

  SingleUserSucces({required this.user});
}
