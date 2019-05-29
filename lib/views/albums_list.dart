import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicplayer/models/album.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:musicplayer/redux/state.dart';
import 'package:musicplayer/redux/viewmodels.dart';
import 'package:musicplayer/views/album_detail.dart';
import 'package:musicplayer/views/util/custom_page_route_builder.dart';

class AlbumsList extends StatefulWidget {
  @override
  _AlbumsListState createState() => _AlbumsListState();
}

class _AlbumsListState extends State<AlbumsList> {
  AlbumListViewModel model;

  Widget _buildGridAlbumsList(Orientation orientation) {
    if (model.isLoading || model.albums == null) {
      return Container();
    } else {
      final albums = model.albums;
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
          final albumArtTag = 'album_art_${album.albumId}';
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  DurationMaterialPageRoute(
                      duration: Duration(milliseconds: 500),
                      builder: (context) =>
                          AlbumDetail(album: album, imageTag: albumArtTag)));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: 1,
                      child: Hero(tag: albumArtTag, child: albumArt)),
                  Container(
                    color: Colors.black12,
                    child: ListTile(
                        title: Text(album.albumName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${album.artist} | $songsCountText')),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AlbumListViewModel>(
      converter: (store) => AlbumListViewModel.fromStore(store),
      builder: (context, model) {
        this.model = model;
        return OrientationBuilder(
          builder: (context, orientation) {
            return _buildGridAlbumsList(orientation);
          },
        );
      },
    );
  }
}
