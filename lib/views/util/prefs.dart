import 'dart:convert';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _prefs;

Future _initPrefs() async {
  if (_prefs == null) {
    _prefs = await SharedPreferences.getInstance();
  }
}

Future<Playlist> createPlaylist(List<Song> songs) async {
  await _initPrefs();
  Playlist playlist = Playlist(songs: songs);
  await _prefs.setString('playlist', jsonEncode(playlist));
  return playlist;
}

Future<Playlist> getPlaylist() async {
  await _initPrefs();
  return Playlist.fromJson(jsonDecode(_prefs.getString('playlist')));
}

Future<bool> addSongToPlaylist(Song song) async {
  await _initPrefs();
  String currentPlaylist;
  try {
    currentPlaylist = _prefs.getString("playlist");
  } catch (e) {
    currentPlaylist = null;
  }
  if (currentPlaylist != null) {
    Playlist playlist = Playlist.fromJson(await jsonDecode(currentPlaylist));
    playlist.songs.add(song);
    await _prefs.setString('playlist', jsonEncode(playlist));
    return true;
  } else {
    return false;
  }
}

Future deletePlaylist(int index) async {
  await _prefs.remove('playlist');
}
