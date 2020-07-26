import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechProvider {
  final double _pitch = 1.0;
  final double _volume = 1.0;
  final String _voice = 'en-gb-x-gba-network';
  
  FlutterTts flutterTts = FlutterTts();
  
  
  Future initFlutterTTS() async {
    flutterTts.setPitch(_pitch);
    flutterTts.setVolume(_volume);
    flutterTts.setVoice(_voice);
    print('Loaded');
  }

  void speak(String say) async {
    flutterTts.speak(say);
  }
}