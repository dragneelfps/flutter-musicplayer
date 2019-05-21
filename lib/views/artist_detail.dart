import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:musicplayer/models/album.dart';
import 'package:musicplayer/models/artist.dart';
import 'package:musicplayer/views/util/custom_page_route_builder.dart';
import 'package:musicplayer/views/util/helpers.dart';

import 'album_detail.dart';
import 'common/detail_appbar.dart';
import 'common/detail_dashboard.dart';

class ArtistDetail extends StatelessWidget {
  final Artist artist;
  final String imageTag;

  List<Widget> _getActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.shuffle),
        onPressed: () {},
      ),
      PopupMenuButton(
        onSelected: (String value) {},
        itemBuilder: (context) {
          return _buildMenuItems();
        },
      )
    ];
  }

  List<PopupMenuEntry<String>> _buildMenuItems() {
    return <PopupMenuItem<String>>[
      PopupMenuItem(
        value: 'biography',
        child: InkWell(onTap: () {}, child: Text('Biography')),
      )
    ];
  }

  List<DataTile> _buildDashboardDataItems() {
    return <DataTile>[
      DataTile(icon: Icons.album, title: '${artist.albums.length} Albums'),
      DataTile(icon: Icons.music_note, title: '${artist.songs.length} Songs'),
      DataTile(
          icon: Icons.timer, title: formatTimestamp(artist.getAlbumLength()))
    ];
  }

  Widget _buildArtistAlbumsList(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / 3;
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: artist.albums.length,
      staggeredTileBuilder: (_) => StaggeredTile.fit(1),
      itemBuilder: (context, index) {
        Album album = artist.albums[index];
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
                    child: ListTile(title: Text(album.albumName)))
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildAlbumSongsList() {
    return artist.songs.map((song) {
      return ListTile(
        title: Text(song.title),
        subtitle: Text(song.album),
        trailing: PopupMenuButton(
          onSelected: (String value) {},
          itemBuilder: (context) {
            return [
              PopupMenuItem(value: 'play_next', child: Text('Play Next'))
            ];
          },
        ),
      );
    }).toList();
  }

  const ArtistDetail({Key key, this.artist, this.imageTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailApp(
          context: context,
          title: artist.artistName,
          actions: _getActions(),
          color: Colors.grey),
      body: Column(
        children: [
          DetailDashboard(
            imageIcon: Icons.music_note,
            imageTag: imageTag,
            dataItems: _buildDashboardDataItems(),
            color: Colors.grey,
          ),
          Expanded(child: _buildArtistAlbumsList(context)),
          Expanded(
            child: ListView(children: _buildAlbumSongsList()),
          )
        ],
      ),
    );
  }
}
