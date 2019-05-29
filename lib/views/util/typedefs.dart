import 'package:flute_music_player/flute_music_player.dart';

typedef Future<void> OnCreateNewPlaylist(List<Song> songs);
typedef Future<void> OnAddSongToPlaylist(Song song);
typedef void OnPlaylistPause();
