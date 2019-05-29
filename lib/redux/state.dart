import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/foundation.dart';
import 'package:musicplayer/models/album.dart';
import 'package:musicplayer/models/artist.dart';
import 'package:musicplayer/models/playlist.dart';

@immutable
class AppState {
  final MainState mainState;
  final PlayerState playerState;

  AppState({@required this.playerState, @required this.mainState});

  factory AppState.initial() => AppState(
      playerState: PlayerState.initial(), mainState: MainState.initial());

  AppState copyWith({PlayerState playerState, MainState mainState}) {
    return AppState(
        playerState: playerState ?? this.playerState,
        mainState: mainState ?? this.mainState);
  }
}

@immutable
class PlayerState {
  final Playlist playlist;
  final bool isPlaying;
  final bool isLoading;
  final int currentSongIndex;

  PlayerState(
      {this.playlist, this.isPlaying, this.isLoading, this.currentSongIndex});

  PlayerState copyWith(
      {Playlist playlist,
      bool isPlaying,
      bool isLoading,
      int currentSongIndex}) {
    return PlayerState(
        playlist: playlist ?? this.playlist,
        isPlaying: isPlaying ?? this.isPlaying,
        isLoading: isLoading ?? this.isLoading,
        currentSongIndex: currentSongIndex ?? this.currentSongIndex);
  }

  factory PlayerState.initial() =>
      PlayerState(isPlaying: false, isLoading: true);

  // Song getCurrentSong() {
  //   if (isLoading == null ||
  //       playlist == null ||
  //       playlist.songs == null ||
  //       playlist.songs.isEmpty) {
  //     return null;
  //   } else {
  //     return playlist.songs[0];
  //   }
  // }
}

@immutable
class MainState {
  final SongsState songsState;
  final AlbumsState albumsState;
  final ArtistsState artitstState;

  MainState({this.songsState, this.albumsState, this.artitstState});

  MainState copyWith(
      {SongsState songsState,
      AlbumsState albumsState,
      ArtistsState artistsState}) {
    return MainState(
        songsState: songsState ?? this.songsState,
        albumsState: albumsState ?? this.albumsState,
        artitstState: artistsState ?? this.artitstState);
  }

  factory MainState.initial() => MainState(
      songsState: SongsState.initial(),
      albumsState: AlbumsState.initial(),
      artitstState: ArtistsState.initial());
}

@immutable
class SongsState {
  final List<Song> songs;
  final bool isLoading;

  SongsState({this.songs, this.isLoading});

  SongsState copyWith({List<Song> songs, bool isLoading}) => SongsState(
      songs: songs ?? this.songs, isLoading: isLoading ?? this.isLoading);

  factory SongsState.initial() => SongsState(isLoading: true);
}

@immutable
class AlbumsState {
  final List<Album> albums;
  final bool isLoading;

  AlbumsState({this.albums, this.isLoading});

  AlbumsState copyWith({List<Album> albums, bool isLoading}) {
    return AlbumsState(
        albums: albums ?? this.albums, isLoading: isLoading ?? this.isLoading);
  }

  factory AlbumsState.initial() => AlbumsState(isLoading: true);
}

@immutable
class ArtistsState {
  final List<Artist> artists;
  final bool isLoading;

  ArtistsState({this.artists, this.isLoading});

  ArtistsState copyWith({List<Artist> artists, bool isLoading}) {
    return ArtistsState(
        artists: artists ?? this.artists,
        isLoading: isLoading ?? this.isLoading);
  }

  factory ArtistsState.initial() => ArtistsState(isLoading: true);
}
