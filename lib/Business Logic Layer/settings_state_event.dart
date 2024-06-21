part of 'settings_state_bloc.dart';

@immutable
abstract class SettingsStateEvent {}

class InitialSettingsStateEvent extends SettingsStateEvent {}

class UpdateVoiceSettingsEvent extends SettingsStateEvent {
  final String gender;
  final String language;

   UpdateVoiceSettingsEvent({required this.gender, required this.language});

  @override
  List<Object> get props => [gender, language];
}
