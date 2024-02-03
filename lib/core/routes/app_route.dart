import 'package:demo/Screens/result.dart';
import 'package:go_router/go_router.dart';
import '../../Screens/splash.dart';
import '../../Screens/hello.dart';
import 'dart:io';
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
      path: "/camera",
      builder: (context, state) => result(_image) ,
  )

]);