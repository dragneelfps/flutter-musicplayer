import 'dart:convert';

import 'package:audioplayer/audioplayer.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:musicplayer/models/album.dart';
import 'package:musicplayer/models/artist.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class PrefsMiddleware extends MiddlewareClass<AppState> {
  final SharedPreferences prefs;

  PrefsMiddleware(this.prefs);

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    if (action is CreateNewPlaylistAction) {
      Playlist playlist = Playlist(songs: action.songs, currentSongIndex: 0);
      prefs.setString('playlist', jsonEncode(playlist)).then((res) {
        store.dispatch(CreateNewPlaylistAction2(playlist));
      });
    }
    next(action);
  }
}

class PlayerMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    if (action is CreateNewPlaylistAction2) {
      //stop player playing
      store.dispatch(StopSongAction());
      //play new playlist
      store.dispatch(
          PlaySongAction(currentSong: action.playlist.getCurrentSong()));
    } else if (action is PauseSongAction) {
      AudioPlayer().pause();
    } else if (action is StopSongAction) {
      AudioPlayer().stop();
    } else if (action is PlaySongAction) {
      print('playing: ${action.currentSong.title}');
      AudioPlayer().play(action.currentSong.uri);
    }
    next(action);
  }
}

class FetchInitialStateMiddleware extends MiddlewareClass<AppState> {
  final SharedPreferences prefs;

  FetchInitialStateMiddleware(this.prefs);

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    if (action is FetchPlayerInitialStateAction) {
      final storedVal = prefs.getString('playlist');
      Playlist playlist =
          storedVal != null ? Playlist.fromJson(jsonDecode(storedVal)) : null;
      next(LoadedPlayerInitialStateAction(playlist: playlist));
    } else if (action is FetchMainInitialStateAction) {
      MusicFinder.allSongs().then((songs) {
        next(LoadedSongsAction(songs: songs));

        List<Album> albums = Album.getAlbumsFromSongs(songs);
        next(LoadedAlbumsAction(albums: albums));

        List<Artist> artists = Artist.getArtistsFromSongs(songs);
        next(LoadedArtistsAction(artits: artists));
      }).catchError((e) {
        next(action);
      });
    }
    next(action);
  }
}
