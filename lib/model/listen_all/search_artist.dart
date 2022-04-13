//歌单列表

import 'artistlist.dart';
import 'safe_convert.dart';
class SearchArtist {
  SearchArtist({
    this.total = '',
    required this.list,
  });

  factory SearchArtist.fromJson(Map<String, dynamic>? json) {
    Map<String, dynamic>? musicList;
    if (json!=null&&json.containsKey("data")){
      musicList = json["data"];
    }
    return SearchArtist(
      total: asString(musicList, "total"),
      list: asList(musicList, 'list').map((e) => ArtistList.fromJson(e) ).toList(),
    );
  }

  final String total;
  final List<ArtistList> list;

  Map<String, dynamic> toJson() => {
  };
}