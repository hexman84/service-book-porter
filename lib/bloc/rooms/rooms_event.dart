import 'package:equatable/equatable.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object> get props => [];
}

class FetchRoomsData extends RoomsEvent {}

class RefreshRoomsData extends RoomsEvent {}

class DeleteRoomsData extends RoomsEvent {}

class ReshowRoomsData extends RoomsEvent {}
