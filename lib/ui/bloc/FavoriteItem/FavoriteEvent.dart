part of 'LoginUserBloc.dart';

abstract class FavoriteUserEvent {}

class InsertFavoriteEvent extends FavoriteUserEvent {
  final Data data;
  InsertFavoriteEvent(this.data);
}

class FavoriteEventClick extends FavoriteUserEvent {}
