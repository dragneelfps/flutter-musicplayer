import 'package:flute_music_player/flute_music_player.dart';
import 'package:musicplayer/models/album.dart';
import 'package:musicplayer/models/artist.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/redux/actions.dart';
import 'package:musicplayer/redux/state.dart';
import 'package:redux/redux.dart';

typedef PlaySong(Song song);
typedef PauseSong();
typedef PlayNextSong();
typedef PlayPreviousSong();

class SongListViewModel {
  final List<Song> songs;
  final Function createNewPlaylist;
  final bool isLoading;

  SongListViewModel({this.createNewPlaylist, this.songs, this.isLoading});

  factory SongListViewModel.fromStore(Store<AppState> store) {
    return SongListViewModel(
        createNewPlaylist: (List<Song> songs) =>
            store.dispatch(CreateNewPlaylistAction(songs)),
        songs: store.state.mainState.songsState.songs,
        isLoading: store.state.mainState.songsState.isLoading);
  }
}

class PlayerViewModel {
  final Playlist playlist;
  final bool isLoading;
  final bool isPlaying;
  final PlaySong playSong;
  final PauseSong pauseSong;
  final PlayPreviousSong playPreviousSong;
  final PlayNextSong playNextSong;

  PlayerViewModel(
      {this.playlist,
      this.isLoading,
      this.isPlaying,
      this.playSong,
      this.pauseSong,
      this.playNextSong,
      this.playPreviousSong});

  factory PlayerViewModel.fromStore(Store<AppState> store) {
    return PlayerViewModel(
        playlist: store.state.playerState.playlist,
        isLoading: store.state.playerState.isLoading,
        isPlaying: store.state.playerState.isPlaying,
        playSong: (Song song) =>
            store.dispatch(PlaySongAction(currentSong: song)),
        pauseSong: () => store.dispatch(PauseSongAction()),
        playNextSong: () {
          store.dispatch(PlayNextSongAction());
        });
  }

  Song getCurrentSong() {
    if (isLoading == null ||
        playlist == null ||
        playlist.songs == null ||
        playlist.songs.isEmpty) {
      return null;
    } else {
      return playlist.songs[0];
    }
  }
}

class AlbumListViewModel {
  final List<Album> albums;
  final bool isLoading;

  AlbumListViewModel({this.albums, this.isLoading});

  factory AlbumListViewModel.fromStore(Store<AppState> store) =>
      AlbumListViewModel(
          albums: store.state.mainState.albumsState.albums,
          isLoading: store.state.mainState.albumsState.isLoading);
}

class ArtistListViewModel {
  final List<Artist> artists;
  final bool isLoading;

  ArtistListViewModel({this.artists, this.isLoading});

  factory ArtistListViewModel.fromStore(Store<AppState> store) =>
      ArtistListViewModel(
          artists: store.state.mainState.artitstState.artists,
          isLoading: store.state.mainState.artitstState.isLoading);
}
