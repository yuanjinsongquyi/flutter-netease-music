import 'alum_detail.dart';
import 'safe_convert.dart';
//推荐歌单
class SuggestSongList {
  SuggestSongList({
    this.code = 0,
    required this.data,
  });

  factory SuggestSongList.fromJson(Map<String, dynamic>? json) {
    Map<String, dynamic>? list;
    if (json!=null&&json.containsKey("data")){
      list = json["data"];
    }
    return SuggestSongList(
      code: asInt(json, 'code'),
      data: asList(list, 'list')
          .map((e) => AlumItem.fromJson(e))
          .toList(),
    );
  }
  final int code;
  final List<AlumItem> data;

  Map<String, dynamic> toJson() => {
    'code': code,
    'result': data.map((e) => e.toJson()),
  };
}


