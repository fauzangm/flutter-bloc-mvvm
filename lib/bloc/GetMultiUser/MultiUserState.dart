part of 'MultiUserBloc.dart';

abstract class MultiUserState {}

class MultiUserInitial extends MultiUserState {}

class MultiUserLoading extends MultiUserState {}

class MultiUserSucces extends MultiUserState {
  final MultiUser user;

  MultiUserSucces({required this.user});
}
