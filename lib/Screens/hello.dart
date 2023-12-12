import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  String maintext = "Welcome to the Know My Money program. "
      "The main goal of the program is to help blind people recognize their paper currencies and help them with paper transactions , "
      " in addition to the advantage of identifying whether the currency is fake or real. We hope you enjoy with us.";

  TextToSpeech tts = TextToSpeech();

  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  speak(String text) async {
    await tts.setLanguage('en-US');
    await tts.setVolume(volume);
    await tts.setRate(rate);
    await tts.setPitch(pitch);
    await tts.speak(text);
  }

  @override
  void initState() {
     tts.speak(maintext);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff080210),
      appBar: AppBar(
        leading: Container(),
        title: const Text('Know My Money'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What is Know My Money ?',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ), //text title
                  const SizedBox(height: 40),
                  Text(maintext,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.white, height: 1.3)),
                  const SizedBox(height: 50),
                ],
              ),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    tts.stop();
                  },
                  backgroundColor: Colors.green,
                  label: Text('Skip'),
                  icon: const Icon(Icons.skip_next),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
