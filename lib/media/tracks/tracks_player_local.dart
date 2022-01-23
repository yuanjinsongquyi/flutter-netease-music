import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:quiet/extension.dart';
import 'package:quiet/repository.dart';

import 'track_list.dart';
import 'tracks_player.dart';

abstract class TracksPlayerLocal extends TracksPlayer {
  var _trackList = const TrackList.empty();

  Track? _current;

  @override
  Track? get current => _current;

  @protected
  set current(Track? value) => _current = value;

  @override
  Future<Track?> getNextTrack() async {
    final index = _trackList.tracks.cast().indexOf(current);
    if (index == -1) {
      return _trackList.tracks.firstOrNull;
    }
    final nextIndex = index + 1;
    if (nextIndex >= _trackList.tracks.length) {
      return null;
    }
    return _trackList.tracks[nextIndex];
  }

  @override
  Future<Track?> getPreviousTrack() async {
    final index = _trackList.tracks.cast().indexOf(current);
    if (index == -1) {
      return _trackList.tracks.lastOrNull;
    }
    final previousIndex = index - 1;
    if (previousIndex < 0) {
      return null;
    }
    return _trackList.tracks[previousIndex];
  }

  @override
  Future<void> insertToNext(Track track) async {
    final index = _trackList.tracks.cast().indexOf(current);
    if (index == -1) {
      return;
    }
    final nextIndex = index + 1;
    if (nextIndex >= _trackList.tracks.length) {
      _trackList.tracks.add(track);
    } else {
      final next = _trackList.tracks[nextIndex];
      if (next != track) {
        _trackList.tracks.insert(nextIndex, track);
      }
    }
    notifyPlayStateChanged();
  }

  @override
  Future<void> playFromMediaId(int trackId) async {
    stop();
    final item = _trackList.tracks.firstWhereOrNull((t) => t.id == trackId);
    if (item != null) {
      _playTrack(item);
    }
  }

  @override
  void setTrackList(TrackList trackList) {
    bool needStop = trackList.id != _trackList.id;
    if (needStop) {
      stop();
      _current = null;
    }
    _trackList = trackList;
    notifyPlayStateChanged();
  }

  @override
  Future<void> setRepeatMode(RepeatMode repeatMode) async {
    // TODO
  }

  @override
  RepeatMode get repeatMode => RepeatMode.all;

  @override
  Future<void> skipToNext() async {
    final next = await getNextTrack();
    if (next != null) {
      _playTrack(next);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    final previous = await getPreviousTrack();
    if (previous != null) {
      _playTrack(previous);
    }
  }

  @override
  TrackList get trackList => _trackList;

  void _playTrack(Track track) {
    scheduleMicrotask(() async {
      final url = await neteaseRepository!.getPlayUrl(track.id);
      if (url.isError) {
        debugPrint('Failed to get play url: ${url.asError!.error}');
        return;
      }
      if (current != track) {
        // skip play. since the track is changed.
        return;
      }
      doPlayItem(track, url.asValue!.value);
    });
    current = track;
    notifyPlayStateChanged();
  }

  @protected
  void doPlayItem(Track track, String url) {}
}
