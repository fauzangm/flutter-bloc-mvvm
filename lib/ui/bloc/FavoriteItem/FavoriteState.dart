part of 'LoginUserBloc.dart';

abstract class FavoriteItemState extends Equatable {
  const FavoriteItemState();
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteItemState {}

class FavoriteStateClicked extends FavoriteItemState {
  const FavoriteStateClicked() : super();
}

class FavoriteLoading extends FavoriteItemState {}

class FavoriterSucces extends FavoriteItemState {
  final Data user;

  LoginUserSucces({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginUserError extends FavoriteItemState {
  final String message;

  LoginUserError(this.message);

  @override
  List<Object> get props => [message];
}
