import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader/loader.dart';
import 'package:quiet/navigation/common/playlist/music_list.dart';
import 'package:quiet/repository.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import '../../model/listen_all/extension.dart';
import '../../model/listen_all/search_songs.dart';
import '../../navigation/mobile/widgets/track_title.dart';
import '../../providers/player_provider.dart';

///song list result
class SongsResultSection extends StatefulWidget {
  const SongsResultSection({Key? key, required this.query}) : super(key: key);

  final String? query;

  @override
  SongsResultSectionState createState() {
    return SongsResultSectionState();
  }
}

class SongsResultSectionState extends State<SongsResultSection>
    with AutomaticKeepAliveClientMixin {
  List<Track> songsList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _PlayList(
        MusicTileConfiguration(
          musics: songsList,
          onMusicTap: (context, item) async {
            // TODO check music is playable?
          },
          child: AutoLoadMoreList(
            loadMore: (count) async {
              // final result = await neteaseRepository!
              //     .search(widget.query, SearchType.song, offset: count);
              // if (result.isValue) {
              //   return LoadMoreResult(
              //       result.asValue!.value["result"]["songs"] ?? []);
              // }
              // return result as Result<List>;
              final value = await KuWo.searchMusic(
                  keyWord: widget.query, page: count, size: 30);
              SearchSongs songs =
                  SearchSongs.fromJson(json.decode(json.encode(value.data)));
              List<Track> temp = songs.list.map((e) => e.toTrack()).toList();
              songsList.addAll(temp);
              setState(() {});
              return LoadMoreResult(temp);
            },
            builder: (context, Track item) {
              // FIXME search item handle.
              return TrackTile(index: songsList.indexOf(item), track: item,);
            },
          ),
        ),
        songsList);
  }

  @override
  bool get wantKeepAlive => true;
}

class _PlayList extends ConsumerWidget {
  const _PlayList(this.child, this.tracks) : super();
  final Widget child;
  final List<Track> tracks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TrackTileContainer.simpleList(
      player: ref.read(playerProvider),
      tracks: tracks,
      child: child,
    );
  }
}
