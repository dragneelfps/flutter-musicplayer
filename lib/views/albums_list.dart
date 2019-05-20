import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/models/album.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AlbumsList extends StatefulWidget {
  final List<Song> songs;
  final bool isLoaded;

  const AlbumsList({Key key, this.songs, this.isLoaded}) : super(key: key);

  @override
  _AlbumsListState createState() =>
      _AlbumsListState(songs: songs, isLoaded: isLoaded);
}

class _AlbumsListState extends State<AlbumsList>
    with AutomaticKeepAliveClientMixin<AlbumsList> {
  @override
  bool get wantKeepAlive => true;

  final List<Song> songs;
  final bool isLoaded;
  List<Album> albums;

  _AlbumsListState({this.songs, this.isLoaded}) {
    print('init Albums');
  }

  @override
  void initState() {
    super.initState();
    if (isLoaded) {
      _loadAlbums();
    }
  }

  void _loadAlbums() async {
    final loadedAlbums = Album.getAlbumsFromSongs(songs);
    print(loadedAlbums);
    setState(() {
      albums = loadedAlbums;
    });
  }

  Widget _buildGridAlbumsList(Orientation orientation) {
    if (!isLoaded || albums == null) {
      return Container();
    } else {
      final crossAxisCount = orientation == Orientation.portrait ? 2 : 6;
      final screenWidth = MediaQuery.of(context).size.width;
      final itemWidth = screenWidth / crossAxisCount;
      return StaggeredGridView.countBuilder(
        crossAxisCount: crossAxisCount,
        itemCount: albums.length,
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          Album album = albums[index];
          final songsCount = album.getSongsCount();
          String songsCountText;
          if (songsCount == 1) {
            songsCountText = '1 Song';
          } else {
            songsCountText = '$songsCount Songs';
          }
          Widget albumArt;
          if (album.albumArt == null) {
            albumArt = Center(
                child: Icon(
              Icons.album,
              size: itemWidth,
            ));
          } else {
            albumArt = Image.asset(album.albumArt);
          }
          return Container(
            padding: EdgeInsets.all(2),
            child: Column(
              children: [
                AspectRatio(aspectRatio: 1, child: albumArt),
                Container(
                  color: Colors.black12,
                  child: ListTile(
                      title: Text(album.albumName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${album.artist} | $songsCountText')),
                )
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        return _buildGridAlbumsList(orientation);
      },
    );
  }
}
