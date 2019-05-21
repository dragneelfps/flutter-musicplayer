import 'package:flutter/material.dart';
import 'package:musicplayer/models/album.dart';
import 'package:musicplayer/views/common/detail_appbar.dart';
import 'package:musicplayer/views/common/detail_dashboard.dart';
import 'package:musicplayer/views/util/helpers.dart';

class AlbumDetail extends StatelessWidget {
  final Album album;

  const AlbumDetail({Key key, @required this.album}) : super(key: key);

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
        value: 'wiki',
        child: InkWell(onTap: () {}, child: Text('Wiki')),
      )
    ];
  }

  List<DataTile> _buildDashboardDataItems() {
    return <DataTile>[
      DataTile(icon: Icons.person, title: album.albumName),
      DataTile(icon: Icons.music_note, title: '${album.getSongsCount()} Songs'),
      DataTile(
          icon: Icons.timer, title: formatTimestamp(album.getAlbumLength()))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailApp(
          context: context, title: album.albumName, actions: _getActions()),
      body: Column(
        children: [
          DetailDashboard(
            imageUri: album.albumArt,
            imageHeroTag: 'album_art',
            dataItems: _buildDashboardDataItems(),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
