import 'safe_convert.dart';
class AlumSongItem {
  AlumSongItem({
    this.id = "",
    this.title = "",
    this.picUrl = "",
    this.duration = 0,
    this.artist = "",
    this.album ="",
    this.artistid = "",
    this.songTimeMinutes = "",
    this.albumid="",
    this.albumpic = "",
  });

  factory AlumSongItem.fromJson(Map<String, dynamic>? json) {
    // Map<String, dynamic>? musicdata;
    // if (json!=null&&json.containsKey("musicdata")){
    //   musicdata = json["musicdata"];
    // }
    return AlumSongItem(
        id: asString(json, 'rid'),
        picUrl: asString(json, 'pic'),
        title: asString(json, 'name'),
        duration: asInt(json, 'duration'),
        artist: asString(json, 'artist'),
        album:asString(json, "album"),
      artistid:asString(json, "artistid"),
      songTimeMinutes:asString(json, "songTimeMinutes"),
      albumid:asString(json, "albumid"),
      albumpic:asString(json, "albumpic"),

    );
  }

  final String id;
  final int duration;
  final String picUrl;
  final String title;
  final String artist;
  final String album;
  final String artistid;
  final String songTimeMinutes;
  final String albumid;
  final String albumpic;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'picUrl': picUrl,
    'info': artist,
    'duration':duration
  };
}