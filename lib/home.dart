import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/views/albums_list.dart';
import 'package:musicplayer/views/artists_list.dart';
import 'package:musicplayer/views/player.dart';
import 'package:musicplayer/views/songs_list.dart';

class Home extends StatefulWidget {
  final AudioPlayer audioPlayer = new AudioPlayer();

  @override
  _HomeState createState() => _HomeState(audioPlayer: audioPlayer);
}

class _HomeState extends State<Home> {
  final AudioPlayer audioPlayer;

  _HomeState({@required this.audioPlayer}) : assert(audioPlayer != null);

  Widget _buildPlayer() {
    return Player();
    // if (_currentPlaylist == null) {
    //   return Container();
    // } else {
    //   return Player();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Music"),
          bottom: TabBar(tabs: [
            Tab(text: 'Songs'),
            Tab(text: 'Albums'),
            Tab(text: 'Artists')
          ]),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  SongsList(),
                  AlbumsList(),
                  ArtistsList(),
                ],
              ),
            ),
            _buildPlayer()
          ],
        ),
      ),
    );
  }
}
