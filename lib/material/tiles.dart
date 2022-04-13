import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quiet/model/listen_all/artist_alum.dart';
import 'package:quiet/providers/navigator_provider.dart';
import 'package:quiet/repository/cached_image.dart';

import '../navigation/common/navigation_target.dart';

class AlbumTile extends ConsumerWidget {
  const AlbumTile({Key? key, required this.album, this.subtitle})
      : super(key: key);

  ///netease album json object
  final ArtistAlum album;

  final String Function(Map album)? subtitle;

  String _defaultSubtitle(ArtistAlum album) {
    final String date = album.releaseDate;
    return "$date 歌曲 ";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String subtitle =  _defaultSubtitle(album);
    return InkWell(
      onTap: () => ref
          .read(navigatorProvider.notifier)
          .navigate(NavigationTargetAlbumDetail(int.parse(album.albumid))),
      child: SizedBox(
        height: 64,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image(
                      image: CachedImage(album.pic), fit: BoxFit.cover),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 4)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                Text(album.album, maxLines: 1),
                const Spacer(),
                Text(subtitle,
                    maxLines: 1, style: Theme.of(context).textTheme.caption),
                const Spacer(),
                const Divider(height: 0)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
