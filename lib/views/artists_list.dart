import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/models/artist.dart';

class ArtistsList extends StatefulWidget {
  final List<Song> songs;

  const ArtistsList({Key key, this.songs}) : super(key: key);

  @override
  _ArtistsListState createState() => _ArtistsListState(songs: songs);
}

class _ArtistsListState extends State<ArtistsList>
    with AutomaticKeepAliveClientMixin<ArtistsList> {
  @override
  bool get wantKeepAlive => true;

  final List<Song> songs;
  List<Artist> artists;

  _ArtistsListState({this.songs});

  @override
  initState() {
    super.initState();
    if (songs != null) {
      _loadArtists();
    }
  }

  void _loadArtists() async {
    final loadedArtists = Artist.getArtistsFromSongs(songs);
    setState(() {
      artists = loadedArtists;
    });
  }

  Widget _buildArtistsList() {
    if (songs == null || artists == null) {
      return new Container();
    } else {
      return ListView(
        children: artists.map((artist) {
          return ListTile(
            onTap: () {},
            leading: Hero(
              child: Icon(Icons.music_note),
              tag: 'album_art',
            ),
            title: Text(artist.artistName),
            subtitle: Text(
                '${artist.albums.length} Albums | ${artist.songs.length} Songs'),
          );
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildArtistsList();
  }
}
