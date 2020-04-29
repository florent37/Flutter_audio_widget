import 'package:audio_widget/src/audio/audio_type.dart';
import 'package:flutter/foundation.dart';

export 'package:audio_widget/src/audio/audio_type.dart';
export 'package:flutter/foundation.dart';

abstract class AudioWidgetPlayer {
  void play();

  void pause();

  bool get isPlaying;

  double get volume;

  set volume(double volume);

  bool get loop;

  set loop(bool loop);

  Duration get totalDuration;

  void open({
    @required String path,
    @required AudioType audioType,
    bool autoStart = true,
    double volume = 1.0,
    bool loop = false,
    Duration initialPosition,
    Function(Duration totalDuration) onReadyToPlay,
    Function() onFinish,
  });

  void stop();

  Stream<Duration> get currentPosition;

  void seek(Duration to);

  void dispose();
}
