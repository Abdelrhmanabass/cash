import 'dart:io';
import 'package:demo/Presentation Layer/Screens/result.dart';
import 'package:demo/Presentation Layer/Screens/voice.dart';
import 'package:demo/core/lang/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../core/constants.dart';

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {

  // Text Variables
  String maintext_EN = " Our CASHY Application will assist you in detecting ,"
      " identifying and counting your money ,"
      " it also tells you whether the currency is fake or not ."
      " All you have to do is open the camera and scan your money to open the Camera just say camera .";

  String maintext_AR = "سيساعدك تطبيق CASHY الخاص بنا في اكتشاف وتحديد وإحصاء أموالك، كما يخبرك ما إذا كانت العملة مزيفة أم لا. فقط افتح الكاميرا و قم بتصوير العمله , لفتح الكاميرا قول 'camera'.";

  // Voice Variables
  final AudioPlayer player = AudioPlayer();
  File? _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var body;


  // Speech to Text Variables
  SpeechToText speech = SpeechToText();
  var islestening = false;
  String speechtext = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    if (prefs!.getString('language') == 'en' && prefs!.getString('gender') == 'female')
    {
      player.play(AssetSource('audios/Female-EN/intro-EN.mp3'));
    }
    else if (prefs!.getString('language') == 'en' && prefs!.getString('gender') == 'male')
    {
      player.play(AssetSource('audios/Male-EN/Cashy-En.mp4'));
    }
    else if (prefs!.getString('language') == 'ar' && prefs!.getString('gender') == 'female')
    {
      player.play(AssetSource('audios/Female-AR/intro-AR.mp3'));
    }
    // else if (prefs!.getString('language') == 'ar' && prefs!.getString('gender') == 'male')
    // {
    //   player.play(AssetSource('audios/Male-AR/intro-AR.mp3'));
    // }


  }

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
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => result(_image!)));
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Stack(children: [
          Image.asset(
            'assets/images/Menu.png', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: ListView(
              children: [
                 ListTile(
                  leading: Icon(Icons.home),
                  title: Text(AppLocalizations.of(context)!.translate('home')),
                ),
                const Divider(
                  color: Colors.green, // Customize the color of the divider
                  thickness: 1,
                  indent: 40,
                  endIndent: 40, // Adjust the thickness of the divider
                ),
                ListTile(
                  leading:  const Icon(Icons.mic),
                  title: Text(AppLocalizations.of(context)!.translate('settings')),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Setting()));
                  },
                ),
                const Divider(
                  color: Colors.green, // Customize the color of the divider
                  thickness: 1,
                  indent: 40,
                  endIndent: 40, // Adjust the thickness of the divider
                ),
                 ListTile(
                  leading: const Icon(Icons.attach_money_rounded),
                  title: Text(AppLocalizations.of(context)!.translate('fake')),
                ),
                const Divider(
                  color: Colors.green, // Customize the color of the divider
                  thickness: 1,
                  indent: 40,
                  endIndent: 40, // Adjust the thickness of the divider
                ),
              ],
            ),
          ),
        ]),
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
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Home.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu,
                          color: Colors.white, size: 35.0),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    const Image(
                      image: AssetImage('assets/images/logo_icon.gif'),
                      height: 70, // Adjust height
                      width: 140,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 140, left: 20, right: 8, bottom: 20),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFBF5),
                    //color: const Color.fromRGBO(255, 251, 245, 0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(4.0, 4.0),
                        // changes position of shadow
                        spreadRadius: 2,
                        // Spread radius
                        blurRadius: 4, // Blur radius
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        // changes position of shadow
                        spreadRadius: 2,
                        // Spread radius
                        blurRadius: 4, // Blur radius
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                    child: Text(
                      AppLocalizations.of(context)!.translate('home_message'),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        player.stop();
                      },
                      backgroundColor: Colors.green,
                      label: Text(
                        AppLocalizations.of(context)!.translate('skip_message'),
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
                          onPressed: () async {
                            // player.stop();
                            await pickImage(ImageSource.camera);
                            //uploadImage();
                          },
                          backgroundColor: Colors.green,
                          label: Text(
                            AppLocalizations.of(context)!.translate('camera_message'),
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(Icons.camera),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            // player.stop();
                            await pickImage(ImageSource.gallery);
                            //uploadImage();
                          },
                          backgroundColor: Colors.green,
                          label: Text(
                            AppLocalizations.of(context)!.translate('camera_message'),
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
        ]),
      ),
    );
  }
}
