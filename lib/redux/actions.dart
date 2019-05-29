import 'package:flute_music_player/flute_music_player.dart';
import 'package:musicplayer/models/album.dart';
import 'package:musicplayer/models/artist.dart';
import 'package:musicplayer/models/playlist.dart';

//For player

class CreateNewPlaylistAction {
  final List<Song> songs;

  CreateNewPlaylistAction(this.songs);
}

class CreateNewPlaylistAction2 {
  final Playlist playlist;

  CreateNewPlaylistAction2(this.playlist);
}

class FetchPlayerInitialStateAction {}

class LoadedPlayerInitialStateAction {
  final Playlist playlist;

  LoadedPlayerInitialStateAction({this.playlist});
}

class PlaySongAction {
  final Song currentSong;

  PlaySongAction({this.currentSong}) : assert(currentSong != null);
}

class PauseSongAction {}

class StopSongAction {}

class PlayNextSongAction {}

class PlayPreviousSongAction {}

// Initial Data loading

class FetchMainInitialStateAction {}

class LoadedSongsAction {
  final List<Song> songs;

  LoadedSongsAction({this.songs});
}

class LoadedAlbumsAction {
  final List<Album> albums;

  LoadedAlbumsAction({this.albums});
}

class LoadedArtistsAction {
  final List<Artist> artits;

  LoadedArtistsAction({this.artits});
}
