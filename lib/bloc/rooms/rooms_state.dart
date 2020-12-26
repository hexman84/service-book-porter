import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:servicebook/models/room.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => [];
}

class RoomsEmpty extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsLoaded extends RoomsState {
  final List<List<Room>> rooms;

  const RoomsLoaded({@required this.rooms});

  @override
  List<Object> get props => [rooms];
}

class RoomsFailure extends RoomsState {}