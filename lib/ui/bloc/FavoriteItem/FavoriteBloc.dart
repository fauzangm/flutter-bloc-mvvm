import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:mvvm_flutter/data/remote/response/LoginResponse.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/domain/usecase/clearDatabaseFavorite.dart';
import 'package:mvvm_flutter/domain/usecase/getMultiUser.dart';
import 'package:mvvm_flutter/domain/usecase/insertFavoritemItem.dart';
import 'package:mvvm_flutter/utils/constant.dart';

import '../../../data/remote/response/MultiUser.dart';
import '../../../domain/usecase/postLoginUser.dart';
part 'FavoriteEvent.dart';
part 'FavoriteState.dart';

class FavoriteUserBloc extends Bloc<FavoriteUserEvent, FavoriteItemState> {
  final InsertFavoriteItem insertFavoriteItem;
  final ClearDBFavoriteUseCase clearDBFavoriteUseCase;

  FavoriteUserBloc(this.insertFavoriteItem, this.clearDBFavoriteUseCase)
      : super(FavoriteInitial()) {
    on<InsertFavoriteEvent>(_onInsertFavoriteEvent);
    on<FavoriteEventClick>(_onEventFavoriteClick);
    on<ClearDbFavoriteEvent>(_onClearDbFavoriteEvent);
  }

  Future<void> _onEventFavoriteClick(
      FavoriteEventClick event, Emitter<FavoriteItemState> emit) async {
    emit(const FavoriteStateClicked());
    emit(FavoriteInitial());
  }

  Future<void> _onClearDbFavoriteEvent(
      ClearDbFavoriteEvent event, Emitter<FavoriteItemState> emit) async {
    var resultData = await clearDBFavoriteUseCase.execute();
    resultData.fold((l) => emit(FavoriteError(l)),
        (r) => emit(const FavoriteSucces(succes: succesDeletAllDB)));
  }

  Future<void> _onInsertFavoriteEvent(
      InsertFavoriteEvent event, Emitter<FavoriteItemState> emit) async {
    var resultData = await insertFavoriteItem.execute(event.data);
    resultData.fold((l) => emit(FavoriteError(l)),
        (r) => emit(const FavoriteSucces(succes: 'Berhasil Save Favorite')));
  }
}
