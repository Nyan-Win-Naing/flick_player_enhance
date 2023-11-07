import 'package:flick_video_player/flick_video_player.dart';
import 'package:flicky_player/blocs/change_play_back_bloc.dart';
import 'package:flicky_player/blocs/show_playback_slider_bloc.dart';
import 'package:flicky_player/blocs/show_playback_slider_event.dart';
import 'package:flicky_player/flicky/flicky_play_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:provider/provider.dart' as provider;

class FlickyPlayerControl extends StatelessWidget {
  const FlickyPlayerControl({
    Key? key,
    this.iconSize = 20,
    this.fontSize = 12,
  }) : super(key: key);
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowPlaybackSliderBloc, bool>(
      builder: (context, isShowSlider) {
        return isShowSlider
            ? const PlaybackSliderView()
            : Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: FlickAutoHideChild(
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ),
                  const PlayAndSeekView(),
                  Positioned.fill(
                    child: VideoControlView(fontSize: fontSize),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    top: 16,
                    child: FullScreenAndPlayBackButtonView(
                      onTapPlayback: () {
                        context
                            .read<ShowPlaybackSliderBloc>()
                            .add(OnTogglePlaybackSlider());
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class PlaybackSliderView extends StatelessWidget {
  const PlaybackSliderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePlayBackBloc, double>(
      builder: (context, speed) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  context
                      .read<ShowPlaybackSliderBloc>()
                      .add(OnTogglePlaybackSlider());
                },
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 70,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: Colors.black,
                          displayColor: Colors.black,
                          fontSizeFactor: 0.7,
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSizeDelta: 0.7,
                        ),
                  ),
                  child: SfSlider(
                    min: 0.5,
                    max: 2,
                    value: speed,
                    interval: 0.5,
                    stepSize: 0.5,
                    showTicks: true,
                    activeColor: Colors.yellow.withOpacity(0.3),
                    inactiveColor: Colors.white.withOpacity(0.4),
                    showLabels: true,
                    enableTooltip: true,
                    showDividers: true,
                    shouldAlwaysShowTooltip: true,
                    edgeLabelPlacement: EdgeLabelPlacement.inside,
                    thumbIcon: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    minorTicksPerInterval: 1,
                    onChanged: (value) {
                      value = value as double;
                      FlickControlManager flickControlManager =
                          provider.Provider.of<FlickControlManager>(context,
                              listen: false);
                      flickControlManager.setPlaybackSpeed(value);
                      context
                          .read<ChangePlayBackBloc>()
                          .add(OnChangePlaybackSpeed(speed: value));
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FullScreenAndPlayBackButtonView extends StatelessWidget {
  final Function onTapPlayback;

  const FullScreenAndPlayBackButtonView({super.key, required this.onTapPlayback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FlickAutoHideChild(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const FlickFullScreenToggle(
              size: 30,
            ),
            IconButton(
              onPressed: () {
                onTapPlayback();
              },
              icon: const Icon(
                Icons.speed,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class VideoControlView extends StatelessWidget {
  const VideoControlView({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return FlickAutoHideChild(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const FlickPlayToggle(
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                FlickCurrentPosition(
                  fontSize: fontSize,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: VideoProgressBarView(),
                ),
                FlickTotalDuration(
                  fontSize: fontSize,
                ),
                const SizedBox(
                  width: 10,
                ),
                const FlickSoundToggle(
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoProgressBarView extends StatelessWidget {
  const VideoProgressBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoProgressBar(
        flickProgressBarSettings: FlickProgressBarSettings(
          height: 5,
          handleRadius: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8,
          ),
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white38,
          getPlayedPaint: ({
            double? handleRadius,
            double? height,
            double? playedPart,
            double? width,
          }) {
            return Paint()
              ..shader = const LinearGradient(colors: [
                Color.fromRGBO(255, 249, 196, 1),
                Color.fromRGBO(255, 235, 59, 1)
              ], stops: [
                0.0,
                0.5
              ]).createShader(
                Rect.fromPoints(
                  const Offset(0, 0),
                  Offset(width!, 0),
                ),
              );
          },
          getHandlePaint: ({
            double? handleRadius,
            double? height,
            double? playedPart,
            double? width,
          }) {
            return Paint()
              ..shader = const RadialGradient(
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.white,
                ],
                stops: [0.0, 0.4, 0.5],
                radius: 0.4,
              ).createShader(
                Rect.fromCircle(
                  center: Offset(playedPart!, height! / 2),
                  radius: handleRadius!,
                ),
              );
          },
        ),
      ),
    );
  }
}

class PlayAndSeekView extends StatelessWidget {
  const PlayAndSeekView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FlickShowControlsAction(
      child: FlickSeekVideoAction(
        child: Center(
          child: FlickVideoBuffer(
            child: FlickAutoHideChild(
              showIfVideoNotInitialized: false,
              child: FlickyPlayToggle(),
            ),
          ),
        ),
      ),
    );
  }
}
