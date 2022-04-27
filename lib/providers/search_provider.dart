import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiet/repository.dart';
import 'package:quiet/repository/data/search_result.dart';
import '../../model/listen_all/extension.dart';
import 'package:netease_api/src/listen_all/api/kuwo/kuwo.dart';
import '../../model/listen_all/search_songs.dart';
import '../../navigation/mobile/widgets/track_title.dart';
import '../../providers/player_provider.dart';

final searchMusicProvider = StateNotifierProvider.family<
    SearchResultStateNotify<Track>, SearchResultState<Track>, String>(
  (ref, query) => _TrackResultStateNotify(query),
);

class SearchResultState<T> with EquatableMixin {
  SearchResultState({
    required this.value,
    required this.query,
    required this.page,
    required this.totalPageCount,
    required this.totalItemCount,
  });

  final AsyncValue<List<T>> value;
  final String query;
  final int page;
  final int totalPageCount;
  final int totalItemCount;

  @override
  List<Object?> get props => [value, query, totalPageCount, totalItemCount];
}

abstract class SearchResultStateNotify<T>
    extends StateNotifier<SearchResultState<T>> {
  SearchResultStateNotify(this.query)
      : super(SearchResultState<T>(
            value: const AsyncValue.loading(),
            page: 1,
            totalPageCount: 0,
            totalItemCount: 0,
            query: query)) {
    _loadQuery(1);
  }

  final String query;

  int get pageSize;

  bool _loading = false;

  int? _totalItemCount;
  int _page = 1;

  void _loadQuery(int page) async {
    if (_loading) {
      return;
    }
    _loading = true;
    _page = page;
    notifyListener(const AsyncValue.loading());
    try {
      final result = await load((page - 1) * pageSize, pageSize);
      _totalItemCount = result.totalCount;
      notifyListener(AsyncValue.data(result.result));
    } catch (error, stacktrace) {
      notifyListener(AsyncValue.error(error, stackTrace: stacktrace));
    } finally {
      _loading = false;
    }
  }

  Future<SearchResult<List<T>>> load(int offset, int count);

  void notifyListener(AsyncValue<List<T>> value) {
    state = SearchResultState<T>(
      value: value,
      query: query,
      totalPageCount:
          _totalItemCount == null ? -1 : (_totalItemCount! / pageSize).round(),
      totalItemCount: _totalItemCount ?? -1,
      page: _page,
    );
  }
}

class _TrackResultStateNotify extends SearchResultStateNotify<Track> {
  _TrackResultStateNotify(String query) : super(query);

  @override
  Future<SearchResult<List<Track>>> load(int offset, int count) async {
    final value = await KuWo.searchMusic(
        keyWord: query, page: offset, size: count);
    SearchSongs songs =
    SearchSongs.fromJson(json.decode(json.encode(value.data)));
    List<Track> temp = songs.list.map((e) => e.toTrack()).toList();
    SearchResult<List<Track>> data = SearchResult<List<Track>>(
      result: temp,
      hasMore: offset<= (int.parse(songs.total)/count),
      totalCount: int.parse(songs.total),
    );
    return Future.value(data);
  }

  @override
  int get pageSize => 100;
}
