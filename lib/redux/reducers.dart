import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/redux/state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

AppState appReducer(AppState state, dynamic action) => AppState(
    playerState: playerReducer(state.playerState, action),
    mainState: MainState(
        songsState: songsReducer(state.mainState.songsState, action),
        albumsState: albumsReducer(state.mainState.albumsState, action),
        artitstState: artistsReducer(state.mainState.artitstState, action)));

final songsReducer = combineReducers<SongsState>(
    [TypedReducer<SongsState, LoadedSongsAction>(_loadedMainState)]);

final albumsReducer = combineReducers<AlbumsState>(
    [TypedReducer<AlbumsState, LoadedAlbumsAction>(_loadedAlbums)]);

final artistsReducer = combineReducers<ArtistsState>(
    [TypedReducer<ArtistsState, LoadedArtistsAction>(_loadedArtits)]);

final playerReducer = combineReducers<PlayerState>([
  // TypedReducer<PlayerState, CreateNewPlaylistAction>(_createNewPlaylist),
  TypedReducer<PlayerState, CreateNewPlaylistAction2>(_createNewPlaylist2),
  TypedReducer<PlayerState, LoadedPlayerInitialStateAction>(_loadIntialState),
  TypedReducer<PlayerState, PlaySongAction>(_playSong),
  TypedReducer<PlayerState, PauseSongAction>(_pauseSong),
  TypedReducer<PlayerState, PlayNextSongAction>(_playNextSong),
  TypedReducer<PlayerState, PlayNextSongAction>(_playPreviousSong)
]);

PlayerState _createNewPlaylist(
    PlayerState state, CreateNewPlaylistAction action) {
  return state.copyWith(playlist: Playlist(songs: action.songs));
}

PlayerState _createNewPlaylist2(
        PlayerState state, CreateNewPlaylistAction2 action) =>
    state.copyWith(playlist: action.playlist);

PlayerState _loadIntialState(
        PlayerState state, LoadedPlayerInitialStateAction action) =>
    state.copyWith(playlist: action.playlist, isLoading: false);

SongsState _loadedMainState(SongsState state, LoadedSongsAction action) =>
    state.copyWith(songs: action.songs, isLoading: false);

AlbumsState _loadedAlbums(AlbumsState state, LoadedAlbumsAction action) =>
    state.copyWith(albums: action.albums, isLoading: false);

ArtistsState _loadedArtits(ArtistsState state, LoadedArtistsAction action) =>
    state.copyWith(artists: action.artits, isLoading: false);

PlayerState _playSong(PlayerState state, PlaySongAction action) =>
    state.copyWith(isPlaying: true);

PlayerState _pauseSong(PlayerState state, PauseSongAction action) =>
    state.copyWith(isPlaying: false);

PlayerState _playNextSong(PlayerState state, PlayNextSongAction action) =>
    state.copyWith(
        isPlaying: true,
        currentSongIndex:
            (state.currentSongIndex + 1) % state.playlist.songs.length);

PlayerState _playPreviousSong(PlayerState state, PlayNextSongAction action) =>
    state.copyWith(
        isPlaying: true,
        currentSongIndex:
            (state.currentSongIndex - 1) % state.playlist.songs.length);
