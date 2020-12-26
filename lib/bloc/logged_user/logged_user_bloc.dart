import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:servicebook/network/api.dart';
import './bloc.dart';

class LoggedUserBloc extends Bloc<LoggedUserEvent, LoggedUserState> {
  final API api = API();

  @override
  LoggedUserState get initialState => InitialLoggedUserState();

  @override
  Stream<LoggedUserState> mapEventToState(
    LoggedUserEvent event,
  ) async* {
    if (event is UploadUser) {
      yield* _mapUserLoadedToState();
    }
    if (event is DeleteUser) {
      yield InitialLoggedUserState();
    }
  }

  Stream<LoggedUserState> _mapUserLoadedToState() async* {
    final secureBox = Hive.box('importantData');
    if (secureBox.get('userName') == null) {
      yield LoggedUserLoading();
      try {
        final token = secureBox.get('token');
        final userName = await api.getMyInfo(token);
        secureBox.put('userName', userName);
        yield LoggedUserLoaded(userName: userName);
      } catch (_) {
        yield LoggedUserFailure();
      }
    } else {
      yield LoggedUserLoading();
      // сделать всю эту часть адекватной
      try {
        final token = secureBox.get('token');
        final userName = await api.getMyInfo(token);
        if (secureBox.get('usernName') != userName)
          secureBox.put('userName', userName);
        yield LoggedUserLoaded(userName: userName);
      } catch (_) {
        yield LoggedUserFailure();
      }
    }
  }
}
