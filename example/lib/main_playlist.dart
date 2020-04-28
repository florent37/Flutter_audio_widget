import 'package:audio_widget/audio_widget.dart';
import 'package:flutter/material.dart';

/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("samplee"),
      ),
      body: MyPageWithAudio(),
    );
  }
}

class MyPageWithAudio extends StatefulWidget {
  @override
  _MyPageWithAudioState createState() => _MyPageWithAudioState();
}

class _MyPageWithAudioState extends State<MyPageWithAudio> {
  bool _play = false;
  String _currentPosition = "";

  @override
  Widget build(BuildContext context) {
    return PlaylistWidget(
      play: _play,
      onPositionChanged: (audio, current, total) {
        setState(() {
          _currentPosition = "${current.inSeconds} / ${total.inSeconds}";
        });
      },
      children: [
        AudioWidget(
          path: "assets/audios/country.mp3",
          onReadyToPlay: (total) {
            setState(() {
              _currentPosition = "0 / ${total.inSeconds}";
            });
          },
          child: Column(
            children: <Widget>[
              Text("Country music"),
              RaisedButton(
                child: _play ? Text("Pause") : Text("Play"),
                onPressed: () {
                  setState(() {
                    _play = !_play;
                  });
                },
              ),
              Text(_currentPosition),
            ],
          ),
        )
      ],
    );
  }
}
*/