import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:netease_api/src/listen_all/entity/music_entity.dart';
import 'package:netease_api/src/listen_all/utils/utils.dart';
import 'package:universal_io/io.dart';

import 'package:netease_api/src/listen_all/utils/answer.dart';
import 'package:netease_api/src/listen_all/utils/types.dart';
import 'package:netease_api/src/listen_all/http/http.dart';
import 'package:netease_api/src/listen_all/utils/utils.dart';

part 'module/album.dart';

part 'module/rank.dart';

part 'module/banner.dart';

part 'module/music.dart';

part 'module/mv.dart';

part 'module/play_list.dart';

part 'module/search.dart';

part 'module/singer.dart';

class KuGou {
  KuGou._();

  ///Banner
  static Future<Answer> banner() {
    return _banner.call({}, []);
  }

  ///新歌推荐
  static Future<Answer> musicList() {
    return _musicList.call({}, []);
  }

  ///歌曲详情
  static Future<Answer> musicInfo({String? hash, String? albumAudioId}) {
    return _musicInfo.call({"hash": hash, "albumAudioId": albumAudioId}, []);
  }

  ///推荐歌单
  static Future<Answer> playList({int? page}) {
    return _playList.call({"page": page}, []);
  }

  ///歌单详情
  static Future<Answer> playListInfo({String? id, int? page}) {
    return _playListInfo.call({"id": id, "page": page}, []);
  }

  ///歌单详情,包含所有歌曲
  static Future<Answer> playListInfoAll({String? id, int? page}) {
    return _playListInfoAll.call({"id": id, "page": page}, []);
  }

  ///排行榜列表
  static Future<Answer> rankList() {
    return _rankList.call({}, []);
  }

  ///排行榜详情
  static Future<Answer> rankInfo({String? rankId}) {
    return _rankInfo.call({"rankId": rankId}, []);
  }

  ///排行榜歌曲
  static Future<Answer> rankSong({String? rankId, int? page, int? size}) {
    return _rankSong.call({"rankId": rankId, "page": page, "size": size}, []);
  }

  ///专辑列表
  static Future<Answer> albumList({int? page}) {
    return _albumList.call({"page": page}, []);
  }

  ///专辑信息
  static Future<Answer> albumInfo({String? albumId}) {
    return _albumInfo.call({"albumId": albumId}, []);
  }

  ///专辑歌曲
  static Future<Answer> albumSong({String? albumId}) {
    return _albumSong.call({"albumId": albumId}, []);
  }

  ///歌手列表
  static Future<Answer> singerList({String? classId, int? page}) {
    return _singerList.call({"classId": classId, "page": page}, []);
  }

  ///歌手信息
  static Future<Answer> singerInfo({
    String? id,
  }) {
    return _singerInfo.call({"id": id}, []);
  }

  ///歌手信息
  static Future<Answer> singerSong({String? id, int? page, int? size}) {
    return _singerSong.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future<Answer> singerAlbum({String? id, int? page, int? size}) {
    return _singerAlbum.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手MV
  static Future<Answer> singerMv({String? id, int? page, int? size}) {
    return _singerMv.call({"id": id, "page": page, "size": size}, []);
  }

  ///MV列表
  static Future<Answer> mvList({int? page}) {
    return _mvList.call({"page": page}, []);
  }

  ///MV详情
  static Future<Answer> mvInfo({String? hash}) {
    return _mvInfo.call({"hash": hash}, []);
  }

  ///搜索提示
  static Future<Answer> searchTip({String? keyword}) {
    return _searchTip.call({"keyword": keyword}, []);
  }

  ///搜索单曲
  static Future<Answer> searchSong({String? keyword, int? page, int? size}) {
    return _searchSong.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索专辑
  static Future<Answer> searchAlbum({String? keyword, int? page, int? size}) {
    return _searchAlbum.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索mv
  static Future<Answer> searchMv({String? keyword, int? page, int? size}) {
    return _searchMv.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索歌单
  static Future<Answer> searchPlayList({String? keyword, int? page, int? size}) {
    return _searchPlayList.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  static Future<Answer> api(String path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.KuGou).copy(data: {'code': 500, 'msg': "url:“$path”未被定义, 请检查", 'path': _api.keys.toList()}));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/banner": _banner,
  "/music/list": _musicList,
  "/music/info": _musicInfo,
  "/playlist": _musicInfo,
  "/playlist/info": _playListInfo,
  "/rank/list": _rankList,
  "/rank/info": _rankInfo,
  "/rank/song": _rankSong,
  "/album/list": _albumList,
  "/album/info": _albumInfo,
  "/album/song": _albumSong,
  "/singer/list": _singerList,
  "/singer/info": _singerInfo,
  "/singer/song": _singerSong,
  "/singer/album": _singerAlbum,
  "/singer/mv": _singerMv,
  "/mv/list": _mvList,
  "/mv/info": _mvInfo,
  "/search/tip": _searchTip,
  "/search/song": _searchSong,
  "/search/album": _searchAlbum,
  "/search/mv": _searchMv,
  "/search/playlist": _searchPlayList,
};

//请求
Future<Answer> _get(String path, {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  Map<String, String> header = {
    "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1 Edg/96.0.4664.93",
    "Cookie": "kg_mid=75a1afdf9b6c2b7f1fb911da060b78ac",
  };

  return Http.get(path, params: params, headers: header).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer(site: MusicSite.KuGou);
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        String data = await value.transform(utf8.decoder).join();
        ans = ans.copy(code: value.statusCode, data: json.decode(data));

        return Future.value(ans);
      } else {
        return Future.value(Answer(site: MusicSite.KuGou, code: 500, data: {'code': value.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.value(const Answer(site: MusicSite.KuGou, code: 500, data: {'code': 500, 'msg': "酷狗对象转换异常"}));
    }
  });
}
