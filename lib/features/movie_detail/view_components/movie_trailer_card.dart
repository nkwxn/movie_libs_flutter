import 'package:flutter/material.dart';
import 'package:movie_libs/features/video_player/video_player_page.dart';

class MovieTrailerCard extends StatelessWidget {
  final String youtubeID;

  const MovieTrailerCard({
    super.key,
    required this.youtubeID,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, VideoPlayerPage.routeName,
            arguments: youtubeID);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text('Trailer Title'),
              ),
              Stack(
                children: [
                  // TODO: replace x0ZNQ0YXyfE with other video ID
                  Image.network(
                    'https://img.youtube.com/vi/$youtubeID/hqdefault.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.black54, blurRadius: 4.0)
                        ],
                        size: 45.0,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
