
import 'package:quiet/model/listen_all/song_detail.dart';

import 'safe_convert.dart';
//推荐歌单
class NewSongList {
  NewSongList({
    required this.child,
  });

  factory NewSongList.fromJson(Map<String, dynamic>? json) => NewSongList(
    child: asList(json, 'child')
        .map((e) => NewSongListSub.fromJson(e))
        .toList(),
  );
  final List<NewSongListSub> child;

  Map<String, dynamic> toJson() => {
    'result': child.map((e) => e.toJson()),
  };
}

class NewSongListSub {
  NewSongListSub({
    required this.child,
    this.type = '',
  });

  factory NewSongListSub.fromJson(Map<String, dynamic>? json) => NewSongListSub(
    child: asList(json, 'child')
        .map((e) => SongListSub.fromJson(e))
        .toList(),
    type: asString(json, "type"),
  );
  final List<SongListSub> child;
  String? type;

  Map<String, dynamic> toJson() => {
    'result': child.map((e) => e.toJson()),
  };
}

class SongListSub {
  SongListSub({
    required this.child,
    this.label,
  });

  factory SongListSub.fromJson(Map<String, dynamic>? json) => SongListSub(
    child: asList(json, 'child')
        .map((e) => SongItem.fromJson(e))
        .toList(),
    label: asString(json, "label"),
  );
  final List<SongItem> child;
  String? label;
  Map<String, dynamic> toJson() => {
    'result': child.map((e) => e.toJson()),
  };
}


