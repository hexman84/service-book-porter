part of 'check_users_bloc.dart';

@immutable
abstract class CheckUsersEvent extends Equatable {
  const CheckUsersEvent();

  @override
  List<Object> get props => [];
}

class CheckInNewUser extends CheckUsersEvent {
  final Room room;
  final String phoneNumber;

  CheckInNewUser({this.room, this.phoneNumber});

  @override
  List<Object> get props => [room, phoneNumber];
}

class CheckOutUser extends CheckUsersEvent {
  final String roomId;
  final User user;

  CheckOutUser({this.roomId, this.user});

  @override
  List<Object> get props => [roomId, user];
}

class AddCheckInUserData extends CheckUsersEvent {
  final String roomId;
  final String userId;

  AddCheckInUserData({this.roomId, this.userId});

  @override
  List<Object> get props => [roomId, userId];
}

class ShowErrorEvent extends CheckUsersEvent {
  final String error;

  ShowErrorEvent(this.error);

  @override
  List<Object> get props => [error];
}
