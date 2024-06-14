import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
          child: ImageWithProgressIndicator(imageFile: widget._image)
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

  Future<void> uploadImage() async {
    var image = widget.imageFile;
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://e863-197-133-51-219.ngrok-free.app/upload"),
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
    } else {
      background = 'assets/images/backgrounds/50EGP.png';
      total = total ;
    }
    return background;
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
