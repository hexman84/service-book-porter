import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:servicebook/bloc/auth/bloc.dart';
import 'package:servicebook/network/api.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final API _api = API();
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final token = await _api.auth(
          login: event.login,
          password: event.password,
          connToken: event.connToken,
        );
        _api.setGoogleToken(token, Hive.box('importantData').get('googleToken'));
        if (token == null) {
          yield LoginFailure(error: 'Проверьте правильность введённых данных');
        } else {
          Hive.box('importantData').put('token', token);
          authenticationBloc.add(LoggedIn(token: token));
          yield LoginInitial();
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
