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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
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
    return AudioWidget.assets(
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
