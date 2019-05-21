import 'package:flutter/material.dart';
import 'package:musicplayer/models/album.dart';
import 'package:musicplayer/views/common/detail_appbar.dart';
import 'package:musicplayer/views/common/detail_dashboard.dart';
import 'package:musicplayer/views/util/helpers.dart';

class AlbumDetail extends StatelessWidget {
  final Album album;
  final String imageTag;

  const AlbumDetail({Key key, @required this.album, this.imageTag})
      : super(key: key);

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

  List<ListTile> _buildAlbumSongsList() {
    return album.songs.map((song) {
      return ListTile(
        title: Text(song.title),
        subtitle: Text(formatTimestamp(song.duration)),
        trailing: PopupMenuButton(
          padding: EdgeInsets.all(0),
          onSelected: (String value) {},
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'play_next',
                child: Text('Play Next'),
              )
            ];
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailApp(
          context: context,
          title: album.albumName,
          actions: _getActions(),
          color: Colors.green),
      body: Column(
        children: [
          DetailDashboard(
            imageUri: album.albumArt,
            imageTag: imageTag,
            dataItems: _buildDashboardDataItems(),
            color: Colors.green,
          ),
          Expanded(
            child: ListView(children: _buildAlbumSongsList()),
          )
        ],
      ),
    );
  }
}
