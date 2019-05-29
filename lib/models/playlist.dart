import 'package:flute_music_player/flute_music_player.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist {
  Playlist({this.songs, this.currentSongIndex});

  @_SongConverter()
  List<Song> songs;

  int currentSongIndex;

  static Playlist currentPlaylist;

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  Song getCurrentSong() {
    if (songs.isEmpty) {
      return null;
    } else {
      return songs[currentSongIndex];
    }
  }
}

class _SongConverter implements JsonConverter<Song, Map<String, dynamic>> {
  const _SongConverter();

  @override
  Song fromJson(Map<String, dynamic> json) {
    return Song.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(Song song) {
    Map<String, dynamic> json = new Map();
    json['id'] = song.id;
    json['title'] = song.title;
    json['uri'] = song.uri;
    json['album'] = song.album;
    json['albumArt'] = song.albumArt;
    json['albumId'] = song.albumId;
    json['duration'] = song.duration;
    return json;
  }
}
