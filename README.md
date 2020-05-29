# audio_widget

**Now included directly into AssetsAudioPlayer**

please use https://github.com/florent37/Flutter-AssetsAudioPlayer

[![sample](./medias/sample.gif)](https://github.com/florent37/Flutter_audio_widget)

(this widget does not display anything)

Play an audio on flutter can be as simple as display an image ! Just add a widget into the tree

```dart
Audio.assets(
  path: "assets/audios/country.mp3",
  play: true, //AudioWidget does not maintain the play state
  child: ...
)
```

