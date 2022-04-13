import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:netease_api/netease_api.dart';
import 'package:quiet/model/listen_all/alum_song_detail.dart';
import 'package:quiet/repository.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import '../model/listen_all/extension.dart';
import '../model/listen_all/new_song_list.dart';
import '../model/listen_all/suggest_alum.dart';
final playlistDetailProvider = StreamProvider.family<PlaylistDetail, int>(
  (ref, playlistId) async* {
    //读缓存数据
    // final local = await neteaseLocalData.getPlaylistDetail(playlistId);
    // if (local != null) {
    //   yield local;
    // }
    // final ret = await neteaseRepository!.playlistDetail(playlistId);
    // var detail = await ret.asFuture;x
    final value = await KuWo?.playListInfo(id: playlistId.toString(),page: 1,size: 20);
    final alumDetail = AlumDetail.fromJson(json.decode(json.encode(value.data)));
    yield PlaylistDetail(
      id: alumDetail.id,
      name: alumDetail.name,
      coverUrl: alumDetail.img,
      trackCount: 20,
      playCount: 0,
      subscribedCount: 20,
      creator: Creator().toUser(),
      description: alumDetail.desc,
      subscribed: true,
      tracks: alumDetail.musicList.map((e) => e.toTrack()).toList(),
      commentCount: 20,
      shareCount: 20,
      trackUpdateTime: 20,
      trackIds: alumDetail.musicList.map((e) => int.parse(e.id)).toList(),
      createTime: DateTime.now(),
    );
    //添加缓存机制
    // if (local != null && detail.trackUpdateTime == local.trackUpdateTime) {
    //   detail = detail.copyWith(tracks: local.tracks);
    // } else if (detail.tracks.length != detail.trackCount) {
    //   final musics = await neteaseRepository!.songDetails(detail.trackIds);
    //   if (musics.isValue) {
    //     detail = detail.copyWith(tracks: musics.asValue!.value);
    //   }
    // }
    // neteaseLocalData.updatePlaylistDetail(detail);
    //yield detail;
  },
);
