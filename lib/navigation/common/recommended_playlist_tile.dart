import 'package:flutter/material.dart';
import 'package:quiet/repository.dart';

class RecommendedPlaylistTile extends StatelessWidget {
  const RecommendedPlaylistTile({
    Key? key,
    required this.playlist,
    required this.onTap,
    required this.width,
    this.imageSize = 80,
  }) : super(key: key);

  final RecommendedPlaylist playlist;

  final VoidCallback onTap;

  final double width;

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Tooltip(
              message: playlist.copywriter,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Image(
                  image: CachedImage(playlist.picUrl),
                  fit: BoxFit.cover,
                  width: imageSize,
                  height: imageSize,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 4)),
            Tooltip(
              message: playlist.name,
              child: Text(playlist.name, maxLines: 2),
            ),
          ],
        ),
      ),
    );
  }
}
