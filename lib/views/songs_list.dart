import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicplayer/redux/state.dart';
import 'package:musicplayer/redux/viewmodels.dart';

typedef void OnSongItemClicked(Song song);

typedef void OnCreateNewPlaylist(List<Song> songs);

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  SongListViewModel model;

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
    if (model.isLoading || model.songs == null) {
      return Container();
    } else {
      final songsTiles = model.songs.map((song) {
        final albumArt = song.albumArt == null
            ? Icon(Icons.album, size: 50)
            : Image.asset(song.albumArt, width: 50, height: 50);
        final uriSplits = song.uri.split('/');
        final folderName = uriSplits.elementAt(uriSplits.length - 2);
        return ListTile(
          onTap: () {
            model.createNewPlaylist(List<Song>()..add(song));
          },
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
    return StoreConnector<AppState, SongListViewModel>(
      converter: (store) => SongListViewModel.fromStore(store),
      builder: (context, model) {
        this.model = model;
        return Column(
          children: [_buildShuffleRow(), _buildSongsList()],
        );
      },
    );
  }
}
