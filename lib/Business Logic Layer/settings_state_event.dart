part of 'settings_state_bloc.dart';

@immutable
abstract class SettingsStateEvent {}

 class InitialSettingsStateEvent extends SettingsStateEvent {}

 class ArabicLanguageEvent extends SettingsStateEvent {}
 class EnglishLanguageEvent extends SettingsStateEvent {}

 class MaleGenderEvent extends SettingsStateEvent {}
 class FemaleGenderEvent extends SettingsStateEvent {}
