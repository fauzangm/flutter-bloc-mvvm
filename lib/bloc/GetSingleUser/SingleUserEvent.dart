part of 'SingleUserBloc.dart';

abstract class SingleUserEvent {}

class GetSingleUserEvent extends SingleUserEvent {
  final int idUser;

  GetSingleUserEvent({required this.idUser});
}
