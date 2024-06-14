import 'package:demo/Presentation Layer/Screens/result.dart';
import 'package:go_router/go_router.dart';
import '../../Presentation Layer/Screens/splash.dart';
import '../../Presentation Layer/Screens/hello.dart';
import 'dart:io';

import '../../Presentation Layer/Screens/voice.dart';
late File _image;

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const MySplach(),
  ),

  GoRoute(
    path: "/hello",
    builder: (context, state) => const Hello(),
  ),

  GoRoute(
      path: "/result",
      builder: (context, state) => result(_image) ,
  ),

  GoRoute(
    path: "/Settings",
    builder: (context, state) => const Setting() ,
  )

]);