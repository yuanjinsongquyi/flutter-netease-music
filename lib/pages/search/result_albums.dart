import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader/loader.dart';
import 'package:quiet/repository.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import '../../material/tiles.dart';
import '../../model/listen_all/artist_alum.dart';
import '../../model/listen_all/safe_convert.dart';

class AlbumsResultSection extends StatefulWidget {
  const AlbumsResultSection({Key? key, this.query}) : super(key: key);
  final String? query;

  @override
  State<AlbumsResultSection> createState() => _AlbumsResultSectionState();
}

class _AlbumsResultSectionState extends State<AlbumsResultSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AutoLoadMoreList<ArtistAlum>(loadMore: (offset) async {
      // final result = await neteaseRepository!
      //     .search(widget.query, SearchType.album, offset: offset);
      // if (result.isError) {
      //   return result.asError!;
      // }
      // final list = result.asValue!.value["result"]["albums"] as List?;
      final value = await KuWo.searchAlbum(keyWord: widget.query,page: offset~/10,size: 10);
      Map<String, dynamic>? result  = json.decode(json.encode(value.data));
      Map<String, dynamic>? alum;
      if (result!=null&&result.containsKey("data")){
        alum = result["data"];
      }
      List<ArtistAlum> list = asList(alum, "albumList").map((e) => ArtistAlum.fromJson(e)).toList();
      return LoadMoreResult(list);
    }, builder: (context, album) {
      return AlbumTile(
        album: album,
      );
    });
  }
}
