import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../generated/assets.dart';

class MySplach extends StatefulWidget {
  const MySplach({super.key});

  @override
  State<MySplach> createState() => _MySplachState();
}

class _MySplachState extends State<MySplach> {

  @override
  void initState() {
    // TODO: implement initState

    Timer(const Duration(seconds: 2), () {
        GoRouter.of(context).push('/hello');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Center(
          child: Image.asset(Assets.imagesLogo),
        ),
      );
  }
}
