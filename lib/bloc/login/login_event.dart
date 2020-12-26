import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String login;
  final String password;
  final String connToken;

  const LoginButtonPressed({
    @required this.login,
    @required this.password,
    @required this.connToken,
  });

  @override
  List<Object> get props => [login, password, connToken];

  @override
  String toString() =>
      'LoginButtonPressed { username: $login, password: $password, connToken: $connToken }';
}
