part of '../qq.dart';

/*
* 电台列表
 */
Future<Answer> _radioList(Map params, List<Cookie> cookie) {
  final data = {
    "format": 'json',
  };
  return _get(
    "https://c.y.qq.com/v8/fcg-bin/fcg_v8_radiolist.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
 * 电台详情
 * 网页上，有个按钮切换，暂时不知道数据是怎么筛选的
 * 默认请求10条音乐，翻页时使用下列参数，不包含radiolist
 * {"songlist":{"module":"pf.radiosvr","method":"GetRadiosonglist","param":{"id":199,"firstplay":0,"num":10}},"comm":{"ct":24,"cv":0}}
 *
 * id 电台Id
 * firstplay 猜测：是不是第一次请求，和加载更多对应
 * num 每页数量
 */
Future<Answer> _radioInfo(Map params, List<Cookie> cookie) {
  final size = params['size'] ?? 10;

  final data = {
    "data": json.encode({
      "songlist": {
        "module": "pf.radiosvr",
        "method": "GetRadiosonglist",
        "param": {"id": params['id'], "firstplay": params["first"] ?? 1, "num": size}
      },
      "radiolist": {
        "module": "pf.radiosvr",
        "method": "GetRadiolist",
        "param": {"ct": "24"}
      },
      "comm": {"ct": 24, "cv": 0}
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
