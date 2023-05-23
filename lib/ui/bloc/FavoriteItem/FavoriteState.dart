part of 'FavoriteBloc.dart';

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

class FavoriteSucces extends FavoriteItemState {
  final String succes;

  const FavoriteSucces({required this.succes});

  @override
  List<Object> get props => [succes];
}

class GetFavoriteSucces extends FavoriteItemState {
  final List<Data> data;

  GetFavoriteSucces({required this.data});

  @override
  List<Object> get props => [data];
}

class FavoriteError extends FavoriteItemState {
  final String message;

  FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
