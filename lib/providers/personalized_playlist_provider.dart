import 'dart:convert';

import 'package:async/async.dart';
import 'package:quiet/repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import '../model/listen_all/extension.dart';
import '../model/listen_all/new_song_list.dart';
import '../model/listen_all/suggest_alum.dart';
final homePlaylistProvider = FutureProvider((ref) async {
  //final list = await neteaseRepository!.personalizedPlaylist(limit: 6);
  final value = await KuWo?.playListRec();
  final list = SuggestSongList.fromJson(json.decode(json.encode(value.data)));
  return Result.value(
    list.data.map((e) => RecommendedPlaylist(
      id: e.id,
      name: e.name,
      copywriter: "",
      picUrl: e.picUrl,
      playCount: 8,
      trackCount: 8,
      alg: "",
    ))
        .toList(),
  ).asFuture;

});

final personalizedNewSongProvider = FutureProvider((ref) async {
  //final list = await neteaseRepository!.personalizedNewSong();
  final value = await KuWo?.songNew();
  final NewSongList newSongList = NewSongList.fromJson(json.decode(json.encode(value.data)));
  final List<NewSongListSub> list = newSongList.child.where((e) => e.type == "newmusic_list").toList();
  return Result.value(
    list[0].child[0].child.map((e) => e.toTrack()).toList(),
  ).asFuture;
});
