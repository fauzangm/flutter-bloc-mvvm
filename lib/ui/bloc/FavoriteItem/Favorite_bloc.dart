import 'package:bloc/bloc.dart';

import 'FavoriteEvent.dart';
import 'FavoriteState.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(false)) {
    on<ToggleFavoriteEvent>((event, emit) {
      if (event is ToggleFavoriteEvent) {
        emit(FavoriteState(event.isFavorite));
      }
    });
  }
}
