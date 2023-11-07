part of 'change_play_back_bloc.dart';

abstract class ChangePlayBackEvent {}

class OnChangePlaybackSpeed extends ChangePlayBackEvent {
  double? speed;

  OnChangePlaybackSpeed({
    this.speed,
  });
}
