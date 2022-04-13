import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader/loader.dart';
import 'package:netease_api/netease_api.dart';
import 'package:quiet/navigation/mobile/artists/page_artist_detail.dart';
import 'package:quiet/repository.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import '../../model/listen_all/search_artist.dart';
import '../../model/listen_all/artistlist.dart';
class ArtistsResultSection extends StatefulWidget {
  const ArtistsResultSection({Key? key, this.query}) : super(key: key);
  final String? query;

  @override
  _ArtistsResultSectionState createState() => _ArtistsResultSectionState();
}

class _ArtistsResultSectionState extends State<ArtistsResultSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AutoLoadMoreList(loadMore: (offset) async {
      // final result = await neteaseRepository!
      //     .search(widget.query, SearchType.artist, offset: offset);
      // if (result.isValue) {
      //   return Result.value(
      //       (result.asValue!.value["result"]["artists"] as List?)!);
      // }
      // return result as Result<List>;
      final value = await KuWo.searchArtist(keyWord: widget.query,page: offset~/10,size: 10);
      SearchArtist artist =
      SearchArtist.fromJson(json.decode(json.encode(value.data)));
      return Result.value(artist.list);
    }, builder: (context, dynamic item) {
      return ArtistTile(artist: item );
    });
  }

  @override
  bool get wantKeepAlive => true;
}

///artist result list tile
class ArtistTile extends StatelessWidget {
   ArtistTile({Key? key, required this.artist}) : super(key: key);
   ArtistList artist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ArtistDetailPage(artistId: int.parse(artist.id));
              }));
            },
      child: SizedBox(
        height: 64,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image(
                    image: CachedImage(artist.pic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 8)),
            Expanded(
                child: Column(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(artist.name))),
                  ],
                )),
                const Divider(height: 0)
              ],
            )),
            const Padding(padding: EdgeInsets.only(right: 8))
          ],
        ),
      ),
    );
  }
}
