import 'package:flute_music_player/flute_music_player.dart';

class Album {
  final int albumId;
  final String albumName;
  final List<Song> songs;
  final String albumArt;
  final String artist;

  Album({this.albumId, this.albumName, this.songs, this.albumArt, this.artist});

  int getSongsCount() => songs.length;

  //Returns length in millis
  int getAlbumLength() {
    int length = 0;
    songs.forEach((song) {
      length += song.duration;
    });
    return length;
  }

  static List<Album> allAlbums = List();

  static Album getAlbumById(int albumId) => allAlbums
      .firstWhere((album) => album.albumId == albumId, orElse: () => null);

  static List<Album> getAlbumsFromSongs(final List<Song> songs) {
    allAlbums = List();
    songs.forEach((song) {
      Album storedAlbum = getAlbumById(song.albumId);
      if (storedAlbum == null) {
        List<Song> songsForThisAlbum = List();
        songsForThisAlbum.add(song);
        Album newAlbum = Album(
            albumId: song.albumId,
            albumName: song.album,
            songs: songsForThisAlbum,
            albumArt: song.albumArt,
            artist: song.artist);
        allAlbums.add(newAlbum);
      } else {
        storedAlbum.songs.add(song);
      }
    });
    return allAlbums;
  }
}
