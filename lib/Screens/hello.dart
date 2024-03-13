import 'dart:convert';
import 'dart:io';
import 'package:demo/Screens/result.dart';
import 'package:demo/Screens/voice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/SettingsProvider.dart';

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {

  String maintext = " Our CASHY Application will assist you in detecting ,"
      " identifying and counting your money ,"
      " it also tells you whether the currency is fake or not ."
      " All you have to do is open the camera and scan your money or open your gallery and select a photo of the currency.";

  final AudioPlayer player = AudioPlayer();
  late File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var body ;
  late final getPickedGender = Provider.of<SettingsProvider>(context,listen: false).pickedGender;
  late final getPickedLanguage = Provider.of<SettingsProvider>(context,listen: false).pickedLanguage;


  @override
  void initState() {
    super.initState();
    if (getPickedLanguage == 'English' && getPickedGender == 'Female') {
      player.play(AssetSource('audios/heba/Cashy-En.mp4'));
    } else if (getPickedLanguage == 'English' && getPickedGender == 'Male') {
      player.play(AssetSource('audios/amr/Cashy-En.mp4'));
    }
  }


  Future<void> pickImage(ImageSource type) async {
    var image = await ImagePicker().pickImage(source: type);
    if (image != null) {
      _image = File(image.path);
      Predict();
      Navigator.push(context, MaterialPageRoute(builder: (context) => result(_image, body)));
      print("result : ${body}");
      //detectImage(_image);
    }
  }

  Future Predict () async
  {
    if(_image == null) return "No Selected Image Please Select Image First";
    String base64 =  base64Encode(_image.readAsBytesSync());
    print(base64);
    Map<String, String> requestHeaders ={'Content-type': 'application/json',
      'Accept': 'application/json',};
    var  response = await http.put(Uri.parse("http://192.168.1.2:5000/api"),body: base64,headers:requestHeaders );
    print(response.body);
    setState(() {
      body = response.body;
    });
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
              children:  [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                Divider(
                  color: Colors.green, // Customize the color of the divider
                  thickness: 1,
                  indent: 40,
                  endIndent: 40, // Adjust the thickness of the divider
                ),
                ListTile(
                  leading: Icon(Icons.mic),
                  title: Text(' Settings'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting()));
                  },
                ),
                Divider(
                  color: Colors.green, // Customize the color of the divider
                  thickness: 1,
                  indent: 40,
                  endIndent: 40, // Adjust the thickness of the divider
                ),
                ListTile(
                  leading: Icon(Icons.attach_money_rounded),
                  title: Text('Fake Currency'),
                ),
                Divider(
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
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Home.jpg'), fit: BoxFit.cover),
          ),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.menu, color: Colors.white, size: 35.0),
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
              padding: const EdgeInsets.only(top: 140, left: 20, right: 8),
              child: Container(
                height: 310,
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
                      offset: Offset(-4.0, -4.0), // changes position of shadow
                      spreadRadius: 2, // Spread radius
                      blurRadius: 4, // Blur radius
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                  child: Text(
                    maintext,
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
      ]),
    );
  }
}
