import 'package:demo/Business%20Logic%20Layer/settings_state_bloc.dart';
import 'package:demo/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/lang/applocalization.dart';
import 'core/routes/app_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(E3rfly());
}

class E3rfly extends StatefulWidget {
  const E3rfly({super.key});

  @override
  State<E3rfly> createState() => _E3rflyState();
}

class _E3rflyState extends State<E3rfly> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsStateBloc()..add(InitialSettingsStateEvent()),
      child: BlocBuilder<SettingsStateBloc, SettingsStateState>(
        builder: (context, state) {
          if (state is AppChangeLanguage ){
            String locale = state.language!;
            return MaterialApp.router(
              locale: Locale(locale),
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (devicelocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (devicelocale != null) {
                    if (devicelocale.languageCode == locale.languageCode) {
                      return devicelocale;
                    }
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          }
          return MaterialApp.router(
            // navigatorKey:NavigationService.navigatorKey,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (devicelocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (devicelocale != null) {
                  if (devicelocale.languageCode == locale.languageCode) {
                    return devicelocale;
                  }
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}

