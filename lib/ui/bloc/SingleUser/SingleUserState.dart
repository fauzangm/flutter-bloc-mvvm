part of 'SingleUserBloc.dart';

abstract class SingleUserState extends Equatable {
  const SingleUserState();

  @override
  List<Object> get props => [];
}

class SingleUserInitial extends SingleUserState {}

class SingleUserLoading extends SingleUserState {}

class SingleUserSucces extends SingleUserState {
  final SingleUser user;

  SingleUserSucces({required this.user});

  @override
  List<Object> get props => [user];
}

class SingleUserError extends SingleUserState {
  final String message;

  SingleUserError(this.message);

  @override
  List<Object> get props => [message];
}
