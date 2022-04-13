part of '../migu.dart';

/*
* 歌单推荐，web
 */
Future<Answer> _playListNewWeb(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.music.migu.cn/migumusic/h5/home/songlist",
    params: {},
    cookie: cookie,
  );
}

/*
* 歌单热门标签
 */
Future<Answer> _playListHotTag(Map params, List<Cookie> cookie) {
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-hottaglist/release",
    params: {},
    cookie: cookie,
  );
}

/*
* 歌单热门推荐(歌单最顶上的几个)
 */
Future<Answer> _playListRec(Map params, List<Cookie> cookie) {
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-header/release",
    params: {},
    cookie: cookie,
  );
}

/*
* 歌单列表
 */
Future<Answer> _playList(Map params, List<Cookie> cookie) {
  final data = {
    'pageNumber': params['page'] ?? '1',
    'tagId': params['tagId'],
    'templateVersion': '1',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-listbytag/release",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌单全部标签
 */
Future<Answer> _playListTagList(Map params, List<Cookie> cookie) {
  final data = {
    'templateVersion': '1',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/musiclistplaza-taglist/release",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌单信息(包含创建者信息)
 */
Future<Answer> _playListInfo(Map params, List<Cookie> cookie) {
  final data = {
    'playlistId': params['id'],
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/playlist/v2.0",
    params: data,
    cookie: cookie,
  ).then((value) async {
    var data = value.data;
    params["size"] = 500;
    var songs = await _playListSong(params, cookie);

    data["data"]["musicList"] = songs.data["data"]["songList"];

    return value.copy(data: data);
  });
}

/*
* 歌单歌曲
 */
Future<Answer> _playListSong(Map params, List<Cookie> cookie) {
  final data = {
    'pageNo': params['page'] ?? 1,
    'pageSize': params['size'] ?? 50,
    'playlistId': params['id'],
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/playlist/song/v2.0",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌单播放量
 */
Future<Answer> _playListPlayNum(Map params, List<Cookie> cookie) {
  final data = {
    'id': (params['contentIds'] as List?)?.join("|"),
    'resourceType': (params['contentTypes'] as List?)?.join("|"),
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/content/queryOPNumItemsAction.do",
    params: data,
    cookie: cookie,
  );
}
