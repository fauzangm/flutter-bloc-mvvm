part of 'MultiUserBloc.dart';

abstract class MultiUserEvent {}

class GetMultiUserEvent extends MultiUserEvent {
  final int idpage;

  GetMultiUserEvent({required this.idpage});
}
