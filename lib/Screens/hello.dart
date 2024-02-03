import 'dart:io';

import 'package:demo/Screens/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {

  String maintext =
      " Our CASHY Application will assist you in detecting ,"
      " identifying and counting your money ,"
      " it also tells you whether the currency is fake or not ."
      " All you have to do is open the camera and scan your money or open your gallery and select a photo of the currency.";
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.play(AssetSource('audios/Cashy.mp4'));
  }

  late File _image;


  Future<void> pickImage(ImageSource type) async {

    var image = await ImagePicker().pickImage(source: type);
    if(image != null) {
      _image = File(image.path);
      Navigator.push(context, MaterialPageRoute(builder: (context) => result(_image)));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff080210),
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          'Cashy',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        backgroundColor: Colors.blueGrey[100],
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
                    'What is Cashy ?',
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
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        player.stop();
                        await pickImage(ImageSource.camera);
                      },
                      backgroundColor: Colors.green,
                      label: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(Icons.skip_next),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            player.stop();
                            pickImage(ImageSource.camera);
                          },
                          backgroundColor: Colors.green,
                          label: const Text(
                            'camera',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(Icons.camera),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            player.stop();
                            pickImage(ImageSource.gallery);
                          },
                          backgroundColor: Colors.green,
                          label: const Text(
                            'gallery',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(Icons.browse_gallery),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}