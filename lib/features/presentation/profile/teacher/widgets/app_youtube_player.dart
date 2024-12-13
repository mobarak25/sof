import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerFlutter extends StatefulWidget {
  const YoutubeVideoPlayerFlutter({super.key});

  @override
  State<YoutubeVideoPlayerFlutter> createState() =>
      _YoutubeVideoPlayerFlutterState();
}

class _YoutubeVideoPlayerFlutterState extends State<YoutubeVideoPlayerFlutter> {
  final videoURL = "https://youtu.be/e9P8uGkdwko?si=CFSb9ws3JNHJcq1w";
  late YoutubePlayerController playerController;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoURL);

    playerController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: false));
    super.initState();
  }

// Method to seek forward 10 seconds
  void seekForward() {
    final currentPosition = playerController.value.position;
    final duration = playerController.value.metaData.duration;
    if (currentPosition.inSeconds + 10 < duration.inSeconds) {
      playerController.seekTo(
        currentPosition + const Duration(seconds: 10),
      );
    }
  }

// Method to seek backward 10 seconds
  void seekBackward() {
    final currentPosition = playerController.value.position;
    if (currentPosition.inSeconds - 10 > 0) {
      playerController.seekTo(currentPosition - const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          YoutubePlayer(controller: playerController),

          // Positioned(
          //   top: 100,
          //   right: 100,
          //   left: 100,
          //   bottom: 100,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       IconButton(
          //         onPressed: seekBackward,
          //         icon: const Icon(
          //           Icons.replay_10,
          //           size: 30,
          //           color: Colors.white54,
          //         ),
          //       ),
          //       const SizedBox(width: 30),
          //       IconButton(
          //         onPressed: seekForward,
          //         icon: const Icon(
          //           Icons.forward_10,
          //           size: 30,
          //           color: Colors.white54,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
