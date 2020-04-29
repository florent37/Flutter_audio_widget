import 'audio_widget_player.dart';
import 'audio_widget_player_assetsaudioplayer.dart';
export 'audio_widget_player_assetsaudioplayer.dart';

typedef AudioWidgetPlayerCreator = AudioWidgetPlayer Function();

///by default, it builds a AudioWidgetPlayerAssetsAudioPlayer, you can override it
///using
/// defaultAudioWidgetPlayer = () => yourClassExtending_AudioWidgetPlayer();
AudioWidgetPlayerCreator defaultAudioWidgetPlayer = () {
  return AudioWidgetPlayerAssetsAudioPlayer();
};
