import 'package:flutter/widgets.dart';

import 'audio_widget.dart';

export 'audio_widget.dart';

//private for now, Work In Progress
class _PlaylistWidget extends StatefulWidget {
  final List<Widget> children;

  final double volume;
  final bool play;
  final bool loop;
  final Function(Audio, Duration current, Duration total)
      onPositionChanged;
  final Function() onReadyToPlay;
  final Function(Audio) onCurrentAudioChanged;
  final Function(Audio) onAudioFinished;
  final Function() onPlaylistFinished;

  const _PlaylistWidget(
      {Key key,
      this.children,
      this.volume = 1.0,
      this.play = true,
      this.loop = false,
      this.onPositionChanged,
      this.onReadyToPlay,
      this.onAudioFinished,
      this.onCurrentAudioChanged,
      this.onPlaylistFinished})
      : super(key: key);

  @override
  _PlaylistWidgetState createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<_PlaylistWidget> {
  int currentPosition = -1;
  List<Widget> children;

  List<Audio> get songs =>
      this.children.where((child) => child is Audio).toList();

  @override
  void initState() {
    super.initState();
    this.children = widget.children;
    if (this.songs?.length ?? 0 > 0) {
      currentPosition = 0;
      updateSongAtIndex(0, play: true);
      //widget.children[0].player.play();
    } else {
      print("cannot open a playlist with 0 songs");
    }
  }

  void updateSongAtIndex(
    int index, {
    bool play,
    Function(Duration current, Duration total) onPositionChanged,
    Function(Duration totalDuration) onReadyToPlay,
    Function() onFinished,
  }) {
    final item = widget.children[index];
    if (item is Audio) {
      widget.children[index] = item.copyWith(
          play: play,
          onPositionChanged: onPositionChanged,
          onReadyToPlay: onReadyToPlay,
          onFinished: onFinished);
    }
  }

  @override
  void didUpdateWidget(_PlaylistWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.children,
    );
  }
}
