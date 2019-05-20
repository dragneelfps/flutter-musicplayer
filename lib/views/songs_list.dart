import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

class SongsList extends StatefulWidget {
  final List<Song> songs;
  final bool isLoaded;

  const SongsList({Key key, this.songs, this.isLoaded}) : super(key: key);

  @override
  _SongsListState createState() =>
      _SongsListState(songs: songs, isLoaded: isLoaded);
}

class _SongsListState extends State<SongsList>
    with AutomaticKeepAliveClientMixin<SongsList> {
  @override
  bool get wantKeepAlive => true;

  final List<Song> songs;
  final bool isLoaded;

  _SongsListState({this.songs, this.isLoaded});

  Widget _buildShuffleRow() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Center(
              widthFactor: 2,
              child: Icon(
                Icons.shuffle,
                size: 25,
              ),
            ),
            SizedBox(width: 16),
            Text(
              'SHUFFLE ALL',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSongsList() {
    if (!isLoaded) {
      return Container();
    } else {
      final songsTiles = songs.map((song) {
        final albumArt = song.albumArt == null
            ? Icon(Icons.album, size: 50)
            : Image.asset(song.albumArt, width: 50, height: 50);
        final uriSplits = song.uri.split('/');
        final folderName = uriSplits.elementAt(uriSplits.length - 2);
        return ListTile(
          leading: albumArt,
          title: Text(song.title),
          subtitle: Text('${song.artist} | $folderName'),
          trailing: PopupMenuButton(
            offset: Offset(0, 100),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'play_song',
                  child: Text('Play'),
                )
              ];
            },
          ),
        );
      }).toList();
      return Expanded(
        child: ListView(
          children: songsTiles,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [_buildShuffleRow(), _buildSongsList()],
    );
  }
}
