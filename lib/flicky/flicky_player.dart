import 'package:flick_video_player/flick_video_player.dart';
import 'package:flicky_player/flicky/flicky_player_control.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FlickyPlayer extends StatefulWidget {
  const FlickyPlayer({Key? key}) : super(key: key);

  @override
  _FlickyPlayerState createState() => _FlickyPlayerState();
}

class _FlickyPlayerState extends State<FlickyPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(
            "https://media.wasolearn.com/StrategyFirst/War_So_Learn/G1_Vimeo_Videos/Grade_1_Eng/Unit_8_My_Family/W_Unit_8_Lesson_2_Letters_of_the_Week_Yy_Zz/playlist.m3u8"),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: const Text(
          "Flicky Player",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: const FlickVideoWithControls(
              controls: FlickyPlayerControl(),
            ),
          ),
        ),
      ),
    );
  }
}
