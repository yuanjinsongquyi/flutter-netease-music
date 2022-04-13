part of '../mix_music.dart';

///Banner
Future<Answer> _banner({List<MusicSite> site = allSite}) async {
  try {
    var value = await Future.wait(allSite.map((e) {
      switch (e) {
        case MusicSite.KuWo:
          return KuWo.banner();
        case MusicSite.MiGu:
          return MiGu.banner();
        case MusicSite.KuGou:
          return KuGou.banner();
        case MusicSite.Baidu:
          return Baidu.banner();
        case MusicSite.Netease:
          return Netease.banner();
        case MusicSite.QQ:
          return QQ.banner();
        default:
          return Future.value(const Answer(site: MusicSite.None, code: 200));
      }
    }).toList());

    var datas = value
        .map((e) {
          switch (e.site) {
            case MusicSite.KuWo:
              try {
                var datas = (e.data["data"] as List?)
                    ?.map((e) => Banner(
                          site: MusicSite.KuWo,
                          id: RegExp(r"[\d]{5,}").stringMatch(e["url"]) ?? "",
                          pic: e["pic"],
                        ))
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.KuWo.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.KuWo.name, "data": []};
              }
            case MusicSite.MiGu:
              try {
                var datas = (e.data["data"] as List?)
                    ?.map((e) => Banner(
                          site: MusicSite.MiGu,
                          id: e["id"],
                          pic: "http:${e["image"]}",
                          title: e["title"],
                        ))
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.MiGu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.MiGu.name, "data": []};
              }
            case MusicSite.KuGou:
              try {
                var datas = (e.data["banner"] as List?)
                    ?.map((e) => Banner(
                          site: MusicSite.KuGou,
                          id: e["id"],
                          pic: e["imgurl"],
                          title: e["title"],
                        ))
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.KuGou.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.KuGou.name, "data": []};
              }
            case MusicSite.Baidu:
              try {
                var datas = (e.data["data"]?["result"] as List?)
                    ?.map((e) => Banner(
                          site: MusicSite.Baidu,
                          id: e["jumpLinkOutput"],
                          pic: e["pic"],
                          title: e["title"],
                          type: e["jumpType"],
                        ))
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.Baidu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Baidu.name, "data": []};
              }
            case MusicSite.Netease:
              try {
                var datas = (e.data["banners"] as List?)
                    ?.map((e) => Banner(
                          site: MusicSite.Netease,
                          id: e["targetId"],
                          pic: e["imageUrl"],
                          title: e["typeTitle"],
                          type: e["targetType"],
                        ))
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.Netease.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Netease.name, "data": []};
              }
            case MusicSite.QQ:
              try {
                var datas = ((e.data["banner"]?["data"]?["shelf"]?["v_niche"] as List?)?.first["v_card"] as List?)
                    ?.map((e) => Banner(
                          site: MusicSite.QQ,
                          id: e["id"],
                          pic: e["cover"],
                          title: e["title"],
                          type: e["jumptype"],
                        ))
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.QQ.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.QQ.name, "data": []};
              }
            default:
              return {};
          }
        })
        .where((element) => element.isNotEmpty)
        .toList();
    return Answer(site: MusicSite.Mix, data: datas);
  } catch (e) {
    print("歌曲列表异常：" + e.toString());
    return const Answer(site: MusicSite.Mix, data: []);
  }
}
