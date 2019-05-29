import 'package:musicplayer/redux/middleware.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reducers.dart';
import 'state.dart';

Future<Store<AppState>> createStore() async {
  final prefs = await SharedPreferences.getInstance();
  return Store(appReducer, initialState: AppState.initial(), middleware: [
    PrefsMiddleware(prefs),
    PlayerMiddleware(),
    FetchInitialStateMiddleware(prefs)
  ]);
}
