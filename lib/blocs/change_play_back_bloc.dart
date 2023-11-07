import 'dart:async';

import 'package:bloc/bloc.dart';

part 'change_play_back_event.dart';

class ChangePlayBackBloc extends Bloc<ChangePlayBackEvent, double> {
  ChangePlayBackBloc() : super(1) {
    on<OnChangePlaybackSpeed>(_onChangePlaybackSpeed);
  }

  Future<void> _onChangePlaybackSpeed(
    OnChangePlaybackSpeed event,
    Emitter<double> emit,
  ) async {
    var newState = event.speed ?? 0;
    emit(newState);
  }
}
