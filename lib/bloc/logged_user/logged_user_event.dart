import 'package:equatable/equatable.dart';

abstract class LoggedUserEvent extends Equatable {
  const LoggedUserEvent();

  @override
  List<Object> get props => [];
}

class UploadUser extends LoggedUserEvent {}

class DeleteUser extends LoggedUserEvent {}
