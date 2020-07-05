import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_app_5/enums/sound_player_state.dart';

class SoundPlayer {
  String mp3Uri = '';
  AudioPlayer audioPlayer = AudioPlayer();
  SoundPlayerState soundPlayerState = SoundPlayerState.idle;

  Future playSound() async {
    audioPlayer.play(mp3Uri);
    soundPlayerState = SoundPlayerState.playing;
  }

  Future loadSound() async {
    final ByteData data = await rootBundle.load('audios/Beeps3secondsv2.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/Beeps3secondsv2'); 
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    mp3Uri = tempFile.uri.toString();
  }
  
  void resetSoundPlayerState() {
    soundPlayerState = SoundPlayerState.idle;
  }

}