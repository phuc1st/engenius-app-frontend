import 'package:flutter_tts/flutter_tts.dart';

final flutterTts = FlutterTts();

Future<void> _initializeTTS() async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1.0);
  await flutterTts.awaitSpeakCompletion(true);
}

Future<void> _speak(String text) async {
  await flutterTts.speak(text);
}
