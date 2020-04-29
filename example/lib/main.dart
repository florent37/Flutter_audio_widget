import 'package:audio_widget/audio_widget.dart';
import 'package:flutter/material.dart';

import './string_duration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        title: Text("sample"),
      ),
      body: SizedBox.expand(child: MyPageWithAudio()),
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
    return Audio.assets(
      path: "assets/audios/country.mp3",
      play: _play,
      onReadyToPlay: (total) {
        setState(() {
          _currentPosition = "${Duration().mmSSFormat} / ${total.mmSSFormat}";
        });
      },
      onPositionChanged: (current, total) {
        setState(() {
          _currentPosition = "${current.mmSSFormat} / ${total.mmSSFormat}";
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Country music"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: CircleBorder(),
              padding: EdgeInsets.all(14),
              color: Theme.of(context).primaryColor,
              child: Icon(
                _play ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _play = !_play;
                });
              },
            ),
          ),
          Text(_currentPosition),
        ],
      ),
    );
  }
}
