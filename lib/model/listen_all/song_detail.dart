import 'safe_convert.dart';
class SongItem {
  SongItem({
    this.id = "",
    this.title = "",
    this.picUrl = "",
    this.duration = 0,
    this.subTitle = "",
    this.artist = '',
    this.album = '',
  });

  factory SongItem.fromJson(Map<String, dynamic>? json) {
    Map<String, dynamic>? musicdata;
    if (json!=null&&json.containsKey("musicdata")){
      musicdata = json["musicdata"];
    }
    return SongItem(
        id: asString(musicdata, 'rid'),
        picUrl: asString(json, 'img'),
        title: asString(json, 'title'),
        duration: asInt(json, 'duration'),
        subTitle: asString(json, 'subtitle'),
        album: asString(musicdata, 'album'),
        artist: asString(musicdata, 'artist')
    );
  }

  final String id;
  final int duration;
  final String picUrl;
  final String title;
  final String subTitle;
  final String artist;
  final String album;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'picUrl': picUrl,
    'info': subTitle,
    'duration':duration
  };
}