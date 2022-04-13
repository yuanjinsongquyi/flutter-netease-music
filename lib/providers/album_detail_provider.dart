import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiet/model/listen_all/safe_convert.dart';
import 'package:quiet/repository.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import '../model/listen_all/alum_song_item.dart';
import '../model/listen_all/extension.dart';
final albumDetailProvider = FutureProvider.family<AlbumDetail, int>(
  (ref, albumId) async {
    // final result = await neteaseRepository!.albumDetail(albumId);
    // final album = await result.asFuture;
    final value = await KuWo.albumInfo(albumId: albumId.toString(),page: 1,size: 30);
    Map<String, dynamic>? result = json.decode(json.encode(value.data));
    Map<String, dynamic>? alum = result!['data'];
    Album _album = Album(name: asString(alum, 'album'), id: asInt(alum, 'albumid'), briefDesc: asString(alum, 'albuminfo'), publishTime: DateTime.now(), company: '', picUrl: asString(alum, 'pic'), description: '', artist: ArtistMini(id: asInt(alum, 'artistid'), name: asString(alum, 'artist'), imageUrl: asString(alum, 'pic')), paid: false, onSale: false, size: asInt(alum, 'total'), liked: false, commentCount: 0, likedCount: 0, shareCount: 0);
    List<Track> list = asList(alum, "musicList").map((e) => AlumSongItem.fromJson(e).toTrack()).toList();
    return AlbumDetail(album: _album,tracks: list);
  },
);
