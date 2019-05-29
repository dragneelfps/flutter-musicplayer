import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicplayer/home.dart';
import 'package:musicplayer/redux/actions.dart';
import 'package:musicplayer/redux/store.dart';
import 'package:redux/redux.dart';
import 'redux/state.dart';

void main() async {
  final store = await createStore();
  runApp(App(store));
}

class App extends StatefulWidget {
  final Store<AppState> store;

  const App(this.store);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(FetchPlayerInitialStateAction());
    widget.store.dispatch(FetchMainInitialStateAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Music Player',
        home: Home(),
      ),
    );
  }
}
