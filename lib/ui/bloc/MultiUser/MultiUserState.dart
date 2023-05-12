part of 'MultiUserBloc.dart';

abstract class MultiUserState extends Equatable {
  const MultiUserState();
  @override
  List<Object> get props => [];
}

class MultiUserInitial extends MultiUserState {}

class MultiUserLoading extends MultiUserState {}

class MultiUserSucces extends MultiUserState {
  final MultiUser user;

  MultiUserSucces({required this.user});

  @override
  List<Object> get props => [user];
}

class MultiUserError extends MultiUserState {
  final String message;

  MultiUserError(this.message);

  @override
  List<Object> get props => [message];
}
