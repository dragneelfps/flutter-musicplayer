import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/redux/state.dart';
import 'package:musicplayer/redux/viewmodels.dart';

import '../main.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  String state = 'paused';

  PlayerViewModel model;

  String getCurrentSong(Playlist playlist) {
    if (playlist == null || playlist.songs == null || playlist.songs.isEmpty) {
      return '-';
    } else {
      return playlist.songs[0].title;
    }
  }

  Widget buildMiniPlayer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black, offset: Offset(0, 1), blurRadius: 3)
      ]),
      child: Column(
        children: [
          Text(getCurrentSong(model.playlist)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                child: Icon(Icons.skip_previous),
                onPressed: () {},
                heroTag: null,
              ),
              SizedBox(width: 16),
              FloatingActionButton(
                child: !model.isPlaying
                    ? Icon(Icons.play_arrow)
                    : Icon(Icons.pause),
                onPressed: () {
                  if (model.isPlaying) {
                    model.pauseSong();
                  } else {
                    model.playSong(model.getCurrentSong());
                  }
                },
                heroTag: null,
              ),
              SizedBox(width: 16),
              FloatingActionButton(
                child: Icon(Icons.skip_next),
                onPressed: () {},
                heroTag: null,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PlayerViewModel>(
      converter: (store) => PlayerViewModel.fromStore(store),
      builder: (context, model) {
        this.model = model;
        if (model.isLoading) {
          return Container();
        } else {
          return buildMiniPlayer();
        }
      },
    );
  }
}
