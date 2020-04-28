import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart'
    as assetsAudioPlayer;

import 'audio_widget_player.dart';

class AudioWidgetPlayerAssetsAudioPlayer extends AudioWidgetPlayer {
  final assetsAudioPlayer.AssetsAudioPlayer _player =
      assetsAudioPlayer.AssetsAudioPlayer.newPlayer();

  @override
  void play() => _player.play();

  @override
  void pause() => _player.pause();

  @override
  bool get isPlaying => _player.isPlaying.value ?? false;

  @override
  void stop() => _player.stop();

  Duration _totalDuration;

  @override
  Duration get totalDuration => _totalDuration;

  assetsAudioPlayer.Audio _mapAudio(String path, AudioType audioType) {
    switch (audioType) {
      case AudioType.network:
        return assetsAudioPlayer.Audio.network(path);
        break;
      case AudioType.asset:
        return assetsAudioPlayer.Audio(path);
        break;
      case AudioType.file:
      default:
        return assetsAudioPlayer.Audio.file(path);
        break;
    }
  }

  @override
  bool get loop => _player.loop;

  @override
  set loop(bool value) => _player.loop = value;

  StreamSubscription onReadyToPlaySubscription;
  StreamSubscription playlistAudioFinishedSubscription;

  @override
  void open({
    @required String path,
    @required AudioType audioType,
    bool autoStart = true,
    double volume = 1.0,
    bool loop = false,
    Duration initialPosition,
    Function(Duration totalDuration) onReadyToPlay,
    Function() onFinish,
  }) {
    final audio = _mapAudio(path, audioType);

    _player.loop = loop;
    _player.open(audio,
        autoStart: autoStart, volume: volume, seek: initialPosition);

    onReadyToPlaySubscription?.cancel();
    onReadyToPlaySubscription = null;
    if (onReadyToPlay != null) {
      onReadyToPlaySubscription = _player.onReadyToPlay.listen((audio) {
        _totalDuration = audio.duration;
        onReadyToPlay(_totalDuration);
      });
    }

    playlistAudioFinishedSubscription?.cancel();
    playlistAudioFinishedSubscription = null;
    if (onFinish != null) {
      playlistAudioFinishedSubscription =
          _player.playlistAudioFinished.listen((event) {
        onFinish();
      });
    }
  }

  @override
  Stream<Duration> get currentPosition => _player.currentPosition;

  @override
  void seek(Duration to) => _player.seek(to);

  @override
  void dispose() {
    onReadyToPlaySubscription?.cancel();
    onReadyToPlaySubscription = null;

    playlistAudioFinishedSubscription?.cancel();
    playlistAudioFinishedSubscription = null;
  }

  @override
  double get volume => _player.volume.value ?? 1.0;

  @override
  set volume(double volume) => _player.setVolume(volume);
}
