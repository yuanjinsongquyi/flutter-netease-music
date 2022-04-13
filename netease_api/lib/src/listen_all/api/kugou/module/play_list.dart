part of '../kugou.dart';

///热门歌单
Future<Answer> _playList(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.kugou.com/plist/index",
    params: {
      "page": params["page"] ?? 1,
      "json": "true",
    },
    cookie: cookie,
  );
}

///@params id : specialid
Future<Answer> _playListInfo(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.kugou.com/plist/list/${params["id"]}",
    params: {
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 500,
      "json": "true",
    },
    cookie: cookie,
  );
}

Future<Answer> _playListInfoAll(Map params, List<Cookie> cookie) {
  return _playListInfo(params, cookie).then((value) async {
    var data = value.data;
    try {
      var info = data["info"]["list"];
      var list = data["list"]["list"]["info"] as List?;
      var total = data["list"]["list"]["total"];
      var pagesize = data["list"]["pagesize"];
      var page = data["list"]["page"];

      var size = getPageSize(total, pagesize);

      var otherSongs = (await Future.wait(
        List.generate(
          size - 1,
          (data) {
            return _playListInfo({"id": params["id"], "page": data + 2}, cookie);
          },
        ),
      ))
          .map(
        (e) {
          var data = e.data;
          var list = data["list"]["list"]["info"] as List?;
          return list;
        },
      ).toList();
      for (var element in otherSongs) {
        list?.addAll((element as List));
      }

      var songs = [];

      ///分割一下list，防止瞬间请求过多导致的失败
      var datas = splitList(list ?? [], 15);
      for (var element in datas) {
        var datas = (await Future.wait((element).map((e) => _musicInfo({"hash": e["hash"], "albumAudioId": e["album_audio_id"]}, cookie)))).map((e) => e.data["data"]).toList();
        songs.addAll(datas);
        await Future.delayed(const Duration(milliseconds: 20));
      }

      var music = songs.map((e) {
        var index = songs.indexOf(e);
        e?["album_audio_id"] = list?[index]?["album_audio_id"];
        return e;
      }).toList();

      info["songs"] = music;

      return value.copy(data: info);
    } catch (e) {
      print(e);
    }

    return value;
  });
}
