part of 'check_users_bloc.dart';

@immutable
abstract class CheckUsersState extends Equatable {
  const CheckUsersState();

  @override
  List<Object> get props => [];
}

class CheckUsersInitial extends CheckUsersState {}

class LoadingCheckUser extends CheckUsersState {}

class ShowError extends CheckUsersState {
  final String error;

  ShowError({this.error});

  @override
  List<Object> get props => [error];
}
