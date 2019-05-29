// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist(
      songs: (json['songs'] as List)
          ?.map((e) => e == null
              ? null
              : const _SongConverter().fromJson(e as Map<String, dynamic>))
          ?.toList())
    ..currentSongIndex = json['currentSongIndex'] as int;
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'songs': instance.songs
          ?.map((e) => e == null ? null : const _SongConverter().toJson(e))
          ?.toList(),
      'currentSongIndex': instance.currentSongIndex
    };
