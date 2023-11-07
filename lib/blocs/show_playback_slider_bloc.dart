import 'dart:async';

import 'package:flicky_player/blocs/show_playback_slider_event.dart';
import 'package:bloc/bloc.dart';

class ShowPlaybackSliderBloc extends Bloc<ShowPlaybackSliderEvent, bool> {
  ShowPlaybackSliderBloc() : super(false) {
    on<OnTogglePlaybackSlider>(_onTogglePlaybackSlider);
  }

  Future<void> _onTogglePlaybackSlider(
    OnTogglePlaybackSlider event,
    Emitter<bool> emit,
  ) async {
    bool newState = !state;
    emit(newState);
  }
}
