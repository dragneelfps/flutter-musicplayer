import 'package:flute_music_player/flute_music_player.dart';
import 'package:musicplayer/models/album.dart';

class Artist {
  final String artistName;
  final List<Album> albums;
  final List<Song> songs;

  static List<Artist> allArtists = List();

  Artist({this.artistName, this.albums, this.songs});

  //Returns length in millis
  int getAlbumLength() {
    int length = 0;
    songs.forEach((song) {
      length += song.duration;
    });
    return length;
  }

  static Artist getArtistByName(String name) => allArtists
      .firstWhere((artist) => artist.artistName == name, orElse: () => null);

  static List<Artist> getArtistsFromSongs(List<Song> songs) {
    allArtists = List();
    songs.forEach((song) {
      Artist storedArtist = getArtistByName(song.artist);
      if (storedArtist == null) {
        List<Song> songsForThisArtist = List();
        songsForThisArtist.add(song);
        Artist newArtist = Artist(
            artistName: song.artist, albums: List(), songs: songsForThisArtist);
        allArtists.add(newArtist);
      } else {
        storedArtist.songs.add(song);
      }
    });
    allArtists.forEach((artist) {
      artist.albums.addAll(Album.getAlbumsFromSongs(artist.songs));
    });
    return allArtists;
  }
}
