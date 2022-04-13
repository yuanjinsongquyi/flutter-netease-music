//歌单列表
import 'package:quiet/model/listen_all/song_detail.dart';

import 'alum_song_item.dart';
import 'safe_convert.dart';
class SearchSongs {
  SearchSongs({
    this.total = '',
    required this.list,
  });

  factory SearchSongs.fromJson(Map<String, dynamic>? json) {
    Map<String, dynamic>? musicList;
    if (json!=null&&json.containsKey("data")){
      musicList = json["data"];
    }
    return SearchSongs(
      total: asString(musicList, "total"),
      list: asList(musicList, 'list').map((e) => AlumSongItem.fromJson(e) ).toList(),
    );
  }

  final String total;
  final List<AlumSongItem> list;

  Map<String, dynamic> toJson() => {
  };
}