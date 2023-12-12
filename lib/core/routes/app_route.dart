import 'package:go_router/go_router.dart';
import '../../Screens/splash.dart';
import '../../Screens/hello.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => MySplach(),
  ),

  GoRoute(
    path: "/hello",
    builder: (context, state) => Hello(),
  ),

]);