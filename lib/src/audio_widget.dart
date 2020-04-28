import 'dart:async';

import 'package:flutter/widgets.dart';

import 'audio/audio_type.dart';
import 'player/audio_widget_player.dart';
import 'player/defaultAudioPlayer.dart';

export 'audio/audio_type.dart';

class AudioWidget extends StatefulWidget {
  final Widget child;

  final bool controlledByPlaylist;
  final String path;
  final AudioType audioType;

  final double volume;
  final bool play;
  final bool loop;
  final Function(Duration current, Duration total) onPositionChanged;

  final Function(Duration totalDuration) onReadyToPlay;
  final Function() onFinished;
  final Duration initialPosition;

  AudioWidget._({
    Key key,
    this.child,
    this.audioType,
    this.path,
    this.volume = 1.0,
    this.play = true,
    this.loop = false,
    this.onPositionChanged,
    this.initialPosition,
    this.onReadyToPlay,
    this.onFinished,
    this.controlledByPlaylist = false,
  }) : super(key: key);

  AudioWidget.assets({
    Key key,
    @required this.child,
    @required this.path,
    this.volume = 1.0,
    this.play = true,
    this.loop = false,
    this.onPositionChanged,
    this.initialPosition,
    this.onReadyToPlay,
    this.onFinished,
  })  : this.audioType = AudioType.asset,
        this.controlledByPlaylist = false,
        super(key: key);

  AudioWidget.network({
    Key key,
    @required this.child,
    @required this.path,
    this.volume = 1.0,
    this.play = true,
    this.loop = false,
    this.onPositionChanged,
    this.initialPosition,
    this.onReadyToPlay,
    this.onFinished,
  })  : this.audioType = AudioType.network,
        this.controlledByPlaylist = false,
        super(key: key);

  AudioWidget.file({
    Key key,
    @required this.child,
    @required this.path,
    this.volume = 1.0,
    this.play = true,
    this.loop = false,
    this.onPositionChanged,
    this.initialPosition,
    this.onReadyToPlay,
    this.onFinished,
  })  : this.audioType = AudioType.file,
        this.controlledByPlaylist = false,
        super(key: key);

  @override
  _AudioWidgetState createState() => _AudioWidgetState();

  AudioWidget copyWith({
    Widget child,
    String path,
    AudioType audioType,
    double volume,
    bool play,
    bool loop,
    Function(Duration current, Duration total) onPositionChanged,
    Function(Duration totalDuration) onReadyToPlay,
    Function() onFinished,
    Duration initialPosition,
    bool controlledByPlaylist,
  }) {
    return AudioWidget._(
      child: child ?? this.child,
      path: path ?? this.path,
      audioType: audioType ?? this.audioType,
      loop: loop ?? this.loop,
      volume: volume ?? this.volume,
      play: play ?? this.play,
      onPositionChanged: onPositionChanged ?? this.onPositionChanged,
      onReadyToPlay: onReadyToPlay ?? this.onReadyToPlay,
      onFinished: onFinished ?? this.onFinished,
      initialPosition: initialPosition ?? this.initialPosition,
      controlledByPlaylist: controlledByPlaylist ?? this.controlledByPlaylist,
    );
  }
}

class _AudioWidgetState extends State<AudioWidget> {
  AudioWidgetPlayer _player;
  StreamSubscription _currentPositionSubscription;

  @override
  void initState() {
    super.initState();
    _player = defaultAudioWidgetPlayer();
    _open();
  }

  void _open() {
    _player.open(
      path: widget.path,
      audioType: widget.audioType,
      autoStart: widget.play,
      volume: widget.volume,
      loop: widget.loop,
      initialPosition: widget.initialPosition,
      onReadyToPlay: _onReadyToPlay,
      onFinish: _onFinished,
    );

    _currentPositionSubscription = _player.currentPosition.listen((current) {
      final total = _player.totalDuration;
      if (current != null && total != null) {
        widget.onPositionChanged(current, total);
      }
    });
  }

  void _onReadyToPlay(Duration totalDuration) {
    //don't set directly widget.onReadyToPlay here because it can change, and open will not be re-called
    if (widget.onReadyToPlay != null) {
      widget.onReadyToPlay(totalDuration);
    }
  }

  void _onFinished() {
    //don't set directly widget.onFinished here because it can change, and open will not be re-called
    if (widget.onFinished != null) {
      widget.onFinished();
    }
  }

  @override
  void didUpdateWidget(AudioWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    //if it's not the same path -> open the new one
    if (widget.path != oldWidget.path) {
      _player.stop();
      _clearSubscriptions();
      _open();
    } else {
      //handle pause/play
      if (widget.play != oldWidget.play) {
        if (widget.play) {
          _player.play();
        } else {
          _player.pause();
        }
      }

      //handle volume
      if (widget.volume != oldWidget.volume) {
        _player.volume = widget.volume;
      }

      //handle loop
      if (widget.loop != oldWidget.loop) {
        _player.loop = widget.loop;
      }

      //handle seek
      if (widget.initialPosition != oldWidget.initialPosition) {
        _player.seek(widget.initialPosition);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _clearSubscriptions() {
    _currentPositionSubscription?.cancel();
    _currentPositionSubscription = null;
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    _clearSubscriptions();
    super.dispose();
  }
}
