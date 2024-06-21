import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../core/constants.dart';

class result extends StatefulWidget {
  late File _image;

  result(File PickedImage ,{super.key} )
  {
    _image = PickedImage ;
  }

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {

  bool loading= true;
  SpeechToText speech = SpeechToText();
  var islestening = false;
  String speechtext = '';
  final AudioPlayer player = AudioPlayer();
  File? _image;

  /// This has to happen only once per app
  void _initSpeech() async {
    islestening = false;
    await speech.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await speech.listen(onResult: (SpeechRecognitionResult result) {
      setState(() {
        speechtext = result.recognizedWords;
        print(speechtext);
        if (speechtext.toLowerCase() == 'camera') {
          pickImage(ImageSource.camera);
        } else if (speechtext.toLowerCase() == 'gallery') {
          pickImage(ImageSource.gallery);
        } else {
          print('Not Recognized');
        }
      });
    });
    setState(() {});
  }

  void _stopListening() async {
    islestening = false;
    await speech.stop();
    setState(() {});
  }

  Future<void> pickImage(ImageSource type) async {
    final image = await ImagePicker().pickImage(source: type);
    setState(() {
      _image = File(image!.path);
    });
    if (image != null) {

    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  void dispose() {
    player.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: GestureDetector(
        onTapDown: (details) async {
          if (!islestening) {
            var available = await speech.initialize();
            if (available) {
              setState(() {
                islestening = true;
                _startListening();
              });
            }
          }
        },
        onTapUp: (details) {
          _stopListening();
        },
        child: Center(
            child: ImageWithProgressIndicator(imageFile: widget._image)
        ),
      ),
    );
  }
}

class ImageWithProgressIndicator extends StatefulWidget {
  final File imageFile;
  ImageWithProgressIndicator({Key? key, required this.imageFile,}) : super(key: key);

  @override
  State<ImageWithProgressIndicator> createState() => _ImageWithProgressIndicatorState();
}

class _ImageWithProgressIndicatorState extends State<ImageWithProgressIndicator> {
  var result;
  late String background ;
  var total =0;
  final AudioPlayer player = AudioPlayer();


  Future<void> uploadImage({File? imagefile}) async {
    var image = imagefile??widget.imageFile;
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://bde4-197-133-63-110.ngrok-free.app/upload"),
    );

    final headers = {"Content-type": "multipart/form-data"};
    request.headers.addAll(headers);


    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        image.path,
        filename: image.path.split("/").last,
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final resJson = jsonDecode(responseBody);
    result = resJson;
    print(resJson);
    setbackground();
    setVoice();
    setState(() {});
  }

  String setbackground() {
    if (result == '10EGP') {
      background = 'assets/images/backgrounds/10EGP.png';
      total = total + 10;
    }
    else if (result == '20EGP') {
      background = 'assets/images/backgrounds/20EGP.png';
      total = total + 20;
    }
    else if (result == '50EGP') {
      background = 'assets/images/backgrounds/50EGP.png';
      total = total + 50;
    }
    else if (result == '100EGP') {
      background = 'assets/images/backgrounds/100EGP.png';
      total = total + 100;
    }
    else if (result == '200EGP') {
      background = 'assets/images/backgrounds/200EGP.png';
      total = total + 200;
    }
    else {
      background = 'assets/images/backgrounds/50EGP.png';
      total = total ;
    }
    return background;
  }

  void setVoice(){

    if(prefs!.getString('language') == 'en') {

        if(prefs!.getString('gender') == 'male') {

            if (result == '100EGP') {
              player.play(AssetSource('audios/Male-EN/100EGP.mp4'));
            }
            else if(result == '10EGP') {
              player.play(AssetSource('audios/Male-EN/10EGP.mp4'));
            }
            else if(result == '5EGP') {
              player.play(AssetSource('audios/Male-EN/5EGP.mp4'));
            }
            else if(result == '20EGP') {
              player.play(AssetSource('audios/Male-EN/20EGP.mp4'));
            }
            else if(result == '50EGP') {
              player.play(AssetSource('audios/Male-EN/50EGP.mp4'));
            }
            else if(result == '200EGP') {
              player.play(AssetSource('audios/Male-EN/200EGP.mp4'));
            }

          }
        else {
          if (result == '100EGP') {
            player.play(AssetSource('audios/Female-EN/100EGP.mp3'));
          }
          else if(result == '10EGP') {
            player.play(AssetSource('audios/Female-EN/10EGP.mp3'));
          }
          else if(result == '5EGP') {
            player.play(AssetSource('audios/Female-EN/5EGP.mp3'));
          }
          else if(result == '20EGP') {
            player.play(AssetSource('audios/Female-EN/20EGP.mp3'));
          }
          else if(result == '50EGP') {
            player.play(AssetSource('audios/Female-EN/50EGP.mp3'));
          }
          else if(result == '200EGP') {
            player.play(AssetSource('audios/Female-EN/200EGP.mp3'));
          }
          }

      }

    else if (prefs!.getString('language') == 'ar') {

        if(prefs!.getString('gender') == 'male') {
          if (result == '100EGP') {
            player.play(AssetSource('audios/Male-EN/100EGP.mp4'));
          }
          else if(result == '10EGP') {
            player.play(AssetSource('audios/Male-EN/10EGP.mp4'));
          }
          else if(result == '5EGP') {
            player.play(AssetSource('audios/Male-EN/5EGP.mp4'));
          }
          else if(result == '20EGP') {
            player.play(AssetSource('audios/Male-EN/20EGP.mp4'));
          }
          else if(result == '50EGP') {
            player.play(AssetSource('audios/Male-EN/50EGP.mp4'));
          }
          else if(result == '200EGP') {
            player.play(AssetSource('audios/Male-EN/200EGP.mp4'));
          }
        }
        else {
          if (result == '100EGP') {
            player.play(AssetSource('audios/Female-AR/100EGP.mp3'));
          }
          else if(result == '10EGP') {
            player.play(AssetSource('audios/Female-AR/10EGP.mp3'));
          }
          else if(result == '5EGP') {
            player.play(AssetSource('audios/Female-AR/5EGP.mp3'));
          }
          else if(result == '20EGP') {
            player.play(AssetSource('audios/Female-AR/20EGP.mp3'));
          }
          else if(result == '50EGP') {
            player.play(AssetSource('audios/Female-AR/50EGP.mp3'));
          }
          else if(result == '200EGP') {
            player.play(AssetSource('audios/Female-AR/200EGP.mp3'));
          }
        }
      }
  }

  @override
  void initState(){
    // TODO: implement initState
    uploadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
        future: Future<File>.delayed(const Duration(seconds: 2), () => widget.imageFile), // Replace this with your actual file loading process
        builder: (context, snapshot) {
          if (result == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading image'),
            );
          }
          else if (result != null) {
            return Center(
              child: Stack(
                children:[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(background), fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 500, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Currency : ',
                                style: TextStyle(fontSize: 20)
                            ),
                            const Expanded(child: SizedBox()),
                            Text(result.toString(),style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Text('Total : ',
                                style: TextStyle(fontSize: 20)
                            ),
                            const Expanded(child: SizedBox()),
                            Text(total.toString(),style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          else {
            return const Center(
              child: Text('No image data'),
            );
          }
          },
        );
  }
}
