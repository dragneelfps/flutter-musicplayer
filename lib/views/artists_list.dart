import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicplayer/redux/state.dart';
import 'package:musicplayer/redux/viewmodels.dart';

import 'artist_detail.dart';
import 'util/custom_page_route_builder.dart';

class ArtistsList extends StatefulWidget {
  @override
  _ArtistsListState createState() => _ArtistsListState();
}

class _ArtistsListState extends State<ArtistsList> {
  ArtistListViewModel model;

  Widget _buildArtistsList() {
    if (model.isLoading || model.artists == null) {
      return new Container();
    } else {
      final artists = model.artists;
      return ListView(
        children: artists.map((artist) {
          final artistImageTag = 'artist_image_${artist.artistName}';
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  DurationMaterialPageRoute(
                      duration: Duration(milliseconds: 500),
                      builder: (context) => ArtistDetail(
                            artist: artist,
                            imageTag: artistImageTag,
                          )));
            },
            leading: Hero(
              child: Icon(Icons.music_note, size: 50),
              tag: artistImageTag,
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
    return StoreConnector<AppState, ArtistListViewModel>(
      converter: (store) => ArtistListViewModel.fromStore(store),
      builder: (context, model) {
        this.model = model;
        return _buildArtistsList();
      },
    );
  }
}
