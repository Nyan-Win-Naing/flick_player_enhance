import 'package:flicky_player/blocs/change_play_back_bloc.dart';
import 'package:flicky_player/blocs/show_playback_slider_bloc.dart';
import 'package:flicky_player/flicky/flicky_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowPlaybackSliderBloc(),
        ),
        BlocProvider(
          create: (context) => ChangePlayBackBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.yellow,
        ),
        useMaterial3: true,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: Colors.white.withOpacity(0.2),
        ),
        sliderTheme: const SliderThemeData(
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
      home: const FlickyPlayer(),
    );
  }
}
