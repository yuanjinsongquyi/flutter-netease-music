//歌单列表

import 'alum_song_item.dart';
import 'safe_convert.dart';
class AlumDetail {
  AlumDetail({
    this.id = 0,
    this.name = "",
    this.img = "",
    this.total = "",
    this.desc = '',
    required this.musicList,
  });

  factory AlumDetail.fromJson(Map<String, dynamic>? json) {
    Map<String, dynamic>? musicList;
    if (json!=null&&json.containsKey("data")){
      musicList = json["data"];
    }
    return AlumDetail(
        id: asInt(musicList, 'id'),
        img: asString(musicList, 'img'),
        name: asString(musicList, 'name'),
        total: asString(musicList, "total"),
        desc: asString(musicList, 'desc'),
        musicList: asList(musicList, 'musicList').map((e) => AlumSongItem.fromJson(e) ).toList(),
    );
  }

  final int id;
  final String img;
  final String name;
  final String total;
  final String desc;
  final List<AlumSongItem> musicList;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'img': img,
    'musicList': musicList,


  };
}