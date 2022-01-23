import 'package:lychee_player/lychee_player.dart';
import 'package:quiet/extension.dart';
import 'package:quiet/media/tracks/tracks_player_local.dart';
import 'package:quiet/repository/data/track.dart';

class TracksPlayerImplLychee extends TracksPlayerLocal {
  LycheePlayer? player;

  @override
  Duration? get bufferedPosition => player?.buffered.value.firstOrNull?.end;

  @override
  Duration? get duration => player?.duration;

  @override
  bool get isBuffering => player?.status == PlayerStatus.buffering;

  @override
  bool get isPlaying => player?.isPlaying ?? false;

  @override
  Future<void> pause() async {
    player?.playWhenReady = false;
  }

  @override
  Future<void> play() async {
    player?.playWhenReady = true;
  }

  @override
  void doPlayItem(Track track, String url) {
    player?.dispose();
    player = LycheePlayer(url, DataSourceType.url)
      ..buffered.addListener(notifyPlayStateChanged)
      ..onStateChanged.addListener(notifyPlayStateChanged);
    player?.playWhenReady = true;
  }

  @override
  double get playbackSpeed => 1;

  @override
  Duration? get position => player?.currentTime;

  @override
  Future<void> seekTo(Duration position) async {
    player?.seek(position);
  }

  @override
  Future<void> setPlaybackSpeed(double speed) async {
    // TODO: implement setPlaybackSpeed
  }

  @override
  Future<void> setVolume(double volume) async {
    player?.volume = volume;
  }

  @override
  Future<void> stop() async {
    player?.dispose();
    player = null;
  }

  @override
  double get volume => player?.volume ?? 1;
}
