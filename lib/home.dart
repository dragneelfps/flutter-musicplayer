import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/views/albums_list.dart';
import 'package:musicplayer/views/songs_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Song> songs;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _loadSongs();
  }

  void _loadSongs() async {
    List<Song> allSongs = await MusicFinder.allSongs();
    setState(() {
      songs = allSongs;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music"),
        bottom: TabBar(
            controller: _tabController,
            tabs: [Tab(text: 'Songs'), Tab(text: 'Albums')]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SongsList(
            songs: songs,
            isLoaded: isLoaded,
          ),
          AlbumsList(
            songs: songs,
            isLoaded: isLoaded,
          )
        ],
      ),
    );
  }
}
