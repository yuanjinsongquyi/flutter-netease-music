import 'safe_convert.dart';
class ArtistAlum {
  ArtistAlum({
    this.albumid = "",
    this.albuminfo = "",
    this.pic = "",
    this.artist = '',
    this.releaseDate = "",
    this.album = "",
    this.artistid = "",
  });

  factory ArtistAlum.fromJson(Map<String, dynamic>? json) {
    return ArtistAlum(
      albumid: asString(json, 'albumid'),
      albuminfo: asString(json, 'albuminfo'),
      pic: asString(json, 'pic'),
      artist: asString(json, 'artist'),
      releaseDate: asString(json, 'releaseDate'),
        album:asString(json, 'album'),
      artistid:asString(json, 'artistid'),
    );
  }

  final String albumid;
  final String albuminfo;
  final String artist;
  final String releaseDate;
  final String album;
  final String artistid;
  final String pic;

  Map<String, dynamic> toJson() => {

  };
}