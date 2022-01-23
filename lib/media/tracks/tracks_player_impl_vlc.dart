import 'dart:async';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:quiet/repository.dart';

import 'tracks_player_local.dart';

extension _SecondsToDuration on double {
  Duration toDuration() {
    return Duration(milliseconds: (this * 1000).round());
  }
}

class TracksPlayerImplVlc extends TracksPlayerLocal {
  TracksPlayerImplVlc() {
    _player.playbackStream.listen((event) {
      if (event.isCompleted) {
        skipToNext();
      }
      notifyPlayStateChanged();
    });
    _player.generalStream.listen((event) => notifyPlayStateChanged());
  }

  final _player = Player(
    id: 0,
    commandlineArguments: ['--no-video'],
  );

  @override
  Duration? get bufferedPosition => _player.bufferingProgress.toDuration();

  @override
  Duration? get duration => _player.position.duration;

  @override
  bool get isBuffering => false;

  @override
  bool get isPlaying => _player.playback.isPlaying;

  @override
  Future<void> pause() async {
    _player.pause();
  }

  @override
  Future<void> play() async {
    _player.play();
  }

  @override
  double get playbackSpeed => _player.general.rate;

  @override
  Duration? get position => _player.position.position;

  @override
  Future<void> seekTo(Duration position) async {
    _player.seek(position);
  }

  @override
  Future<void> setPlaybackSpeed(double speed) async {
    _player.setRate(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    _player.setVolume(volume);
    notifyPlayStateChanged();
  }

  @override
  Future<void> stop() async {
    _player.stop();
  }

  @override
  double get volume => _player.general.volume;

  @override
  void doPlayItem(Track track, String url) {
    _player.open(Media.network(url), autoStart: true);
  }
}
