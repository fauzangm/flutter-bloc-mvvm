abstract class FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final bool isFavorite;

  ToggleFavoriteEvent(this.isFavorite);
}
