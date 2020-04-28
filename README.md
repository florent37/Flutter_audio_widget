# audio_widget

```dart
AudioWidget.assets(
  path: "assets/audios/country.mp3",
  play: true, //AudioWidget does not maintain the play state
  child: ...
)
```

# Update

Like usual Flutter widgets, just update the parameters of the AudioWidget

```dart
//inside a stateful widget

bool _play = false;

@override
Widget build(BuildContext context) {
  return AudioWidget.assets(
     path: "assets/audios/country.mp3",
     play: _play,
     child: RaisedButton(
       child: Text(
         _play ? "pause" : "play",
       ),
       onPressed: () {
         setState(() {
           _play = !_play;
         });
       },
     ),
  );
}
```

# Listeners

```dart
AudioWidget.assets(
  path: "assets/audios/country.mp3",
  play: _play,

  onReadyToPlay: (duration) {
     //onReadyToPlay
  },
  
  onPositionChanged: (current, duration) {
     //onReadyToPlay
  },

  child: ...
)
```