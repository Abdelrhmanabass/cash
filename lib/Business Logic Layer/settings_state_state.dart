part of 'settings_state_bloc.dart';

@immutable
abstract class SettingsStateState {}


class SettingsStateInitial extends SettingsStateState {}

class AppChangeLanguage extends SettingsStateState {
  final String? language;
  AppChangeLanguage({this.language});
}

class AppChangeGender extends SettingsStateState {
  final String? gender;
  AppChangeGender({this.gender});

}



