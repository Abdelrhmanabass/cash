part of 'settings_state_bloc.dart';

@immutable
abstract class SettingsStateState {}


class SettingsStateInitial extends SettingsStateState {}

class SettingsLoaded extends SettingsStateState {
  final String gender;
  final String language;

   SettingsLoaded({required this.gender, required this.language});

  @override
  List<Object> get props => [gender, language];
}

class SettingsError extends SettingsStateState {
  final String error;

   SettingsError({required this.error});

  @override
  List<Object> get props => [error];
}


