import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoggedUserState extends Equatable {
  const LoggedUserState();

  @override
  List<Object> get props => [];
}

class InitialLoggedUserState extends LoggedUserState {}

class LoggedUserLoading extends LoggedUserState {}

class LoggedUserLoaded extends LoggedUserState{
  final String userName;

  const LoggedUserLoaded({@required this.userName});

  @override
  List<Object> get props => [userName];
}

class LoggedUserFailure extends LoggedUserState {}
