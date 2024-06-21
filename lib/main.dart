  import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants.dart';
import 'core/lang/applocalization.dart';
import 'core/routes/app_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Business Logic Layer/settings_state_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   prefs = await SharedPreferences.getInstance();
  runApp(const E3rfly());
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

          if (state is SettingsLoaded) {
            return MaterialApp.router(
              locale: Locale(state.language),
              title: 'E3rfly',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates:  [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (deviceLocale != null) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale.languageCode == locale.languageCode) {
                      return locale;
                    }
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            );
          }
          else if (state is SettingsError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Error: ${state.error}')),
              ),
            );
          }
          return MaterialApp(
            home: Scaffold(
              body: const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
