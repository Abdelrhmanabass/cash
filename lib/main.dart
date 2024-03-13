import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/SettingsProvider.dart';
import 'core/routes/app_route.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => SettingsProvider(),
        child: const E3rfly(),
      )
  );
}


class E3rfly extends StatefulWidget {
  const E3rfly({super.key});

  @override
  State<E3rfly> createState() => _E3rflyState();
}

class _E3rflyState extends State<E3rfly> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router (
      // navigatorKey:NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

