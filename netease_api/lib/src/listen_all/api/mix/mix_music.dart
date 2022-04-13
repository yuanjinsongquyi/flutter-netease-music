import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:netease_api/src/listen_all/api/baidu/baidu.dart';
import 'package:netease_api/src/listen_all/api/kugou/kugou.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import 'package:netease_api/src/listen_all/api/migu/migu.dart';
import 'package:netease_api/src/listen_all/api/my_free_mp3/my_free_mp3.dart';
import 'package:netease_api/src/listen_all/api/netease/netease.dart';
import 'package:netease_api/src/listen_all/api/qq/qq.dart';
import 'package:netease_api/src/listen_all/entity/music_entity.dart';
import 'package:netease_api/src/listen_all/utils/answer.dart';
import 'package:netease_api/src/listen_all/http/http.dart';
import 'package:netease_api/src/listen_all/utils/utils.dart';

part 'module/album.dart';

part 'module/banner.dart';

part 'module/playlist.dart';

part 'module/song.dart';

class MixMusic {
  MixMusic._();

  static Future<Answer> banner({List<MusicSite> site = allSite}) {
    return _banner(site: site);
  }

  static Future<Answer> playlistRec({List<MusicSite> site = allSite}) {
    return _playlistRec(site: site);
  }

  static Future<Answer> playlistInfo({required String id, required String site}) {
    return _playlistInfo(id: id, siteName: site);
  }

  static Future<Answer> albumNew({List<MusicSite> site = allSite}) {
    return _albumNew(site: site);
  }

  static Future<Answer> albumInfo({required String id, required String site}) {
    return _albumInfo(id: id, siteName: site);
  }

  static Future<Answer> songNew({List<MusicSite> site = allSite}) {
    return _songNew(site: site);
  }

  static Future<Answer> getUrl({required List<dynamic> songs, bool withEmpty = true}) async {
    var datas = await _getUrl(songs: songs, withEmpty: withEmpty);
    return Answer(site: MusicSite.Mix, data: datas);
  }

  static Future<Answer> getLrc({required Map songs}) async {
    var datas = await _getLrc(songs: songs);
    return Answer(site: MusicSite.Mix, data: datas);
  }

  static Future<Answer> matchMusic({String? name, String? artist, List<MusicSite> site = allSite}) {
    return _matchMusic(name: name, artist: artist, site: site);
  }
}
