part of 'FavoriteBloc.dart';

abstract class FavoriteUserEvent extends Equatable {
  const FavoriteUserEvent();
  @override
  List<Object?> get props => [];
}

class InsertFavoriteEvent extends FavoriteUserEvent {
  final Data data;
  const InsertFavoriteEvent(this.data);
  @override
  List<Object?> get props => [data];
}

class FavoriteEventClick extends FavoriteUserEvent {}

class ClearDbFavoriteEvent extends FavoriteUserEvent {}

class GetFavoriteEvent extends FavoriteUserEvent {}
