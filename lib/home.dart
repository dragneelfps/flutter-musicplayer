import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/views/albums_list.dart';
import 'package:musicplayer/views/artists_list.dart';
import 'package:musicplayer/views/songs_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Song> songs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _loadSongs();
  }

  void _loadSongs() async {
    List<Song> allSongs = await MusicFinder.allSongs();
    setState(() {
      songs = allSongs;
    });
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
        body: TabBarView(
          children: [
            SongsList(songs: songs),
            AlbumsList(songs: songs),
            ArtistsList(songs: songs),
          ],
        ),
      ),
    );
  }
}
