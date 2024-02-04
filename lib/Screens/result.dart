import 'dart:io';
import 'package:flutter/material.dart';

class result extends StatefulWidget {
  late File _image;
  List _predictions = [0];
  result(File PickedImage, List _OutoutPrediction ,{super.key} )
  {
    _image = PickedImage ;
    _predictions = _OutoutPrediction ;
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
      body: Column(
        children: [
          Center(
          child: SizedBox(
            width: 500,
            height: 500,
            child: ImageWithProgressIndicator(imageFile: widget._image),
          ),
        ),
          Text(widget._predictions.toString()),
        ]
      ),
    );
  }
}

class ImageWithProgressIndicator extends StatelessWidget {
  final File imageFile;

  const ImageWithProgressIndicator({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
        future: Future<File>.delayed(const Duration(seconds: 2), () => imageFile), // Replace this with your actual file loading process
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading image'),
            );
          } else if (snapshot.hasData) {
            return Image.file(snapshot.data!);      //for editing image here <<
          } else {
            return const Center(
              child: Text('No image data'),
            );
          }
          },
        );
  }
}
