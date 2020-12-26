import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/network/api.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final API api = API();

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      var dataInfo = Hive.box('importantData').get('token');
      final hasToken = dataInfo == null ? false : true;
      if (hasToken) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield Loading();
      Hive.box('importantData').put('token', event.token);
      yield Authenticated();
    }
    if (event is LoggedOut) {
      yield Loading();
      Hive.box('importantData').delete('token');
      yield Unauthenticated();
    }
  }
}
