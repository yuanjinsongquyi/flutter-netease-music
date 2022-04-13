import 'package:quiet/model/listen_all/song_detail.dart';

import '../../repository/data/track.dart';
import 'alum_song_item.dart';

extension SongTrack on SongItem {
  Track toTrack() => Track(
        id: int.parse(id),
        imageUrl: picUrl,
        artists: [],
        album: null,
        uri: "",
        type: TrackType.free,
        duration: Duration(seconds: duration),
        name: title,
      );
}
extension AlumSongTrack on AlumSongItem {
  Track toTrack() => Track(
    id: int.parse(id),
    imageUrl: picUrl,
    artists: [],
    album: AlbumMini(picUri: albumpic, name: album, id: int.parse(albumid),),
    uri: "",
    type: TrackType.free,
    duration: Duration(seconds: duration),
    name: title,
  );
}
