import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'settings_state_event.dart';
part 'settings_state_state.dart';

class SettingsStateBloc extends Bloc<SettingsStateEvent, SettingsStateState> {
  late SharedPreferences prefs;
  SettingsStateBloc() : super(SettingsStateInitial()) {
    on<InitialSettingsStateEvent>(_onInitialSettingsStateEvent);
    on<UpdateVoiceSettingsEvent>(_onUpdateVoiceSettingsEvent);
  }
  Future<void> _onInitialSettingsStateEvent(
      InitialSettingsStateEvent event, Emitter<SettingsStateState> emit) async {
    try {
      prefs = await SharedPreferences.getInstance();
      final gender = prefs.getString('gender') ?? 'male';
      final language = prefs.getString('language') ?? 'en';
      emit(SettingsLoaded(gender: gender, language: language));
    } catch (e) {
      emit(SettingsError(error: e.toString()));
    }
  }

  Future<void> _onUpdateVoiceSettingsEvent(
      UpdateVoiceSettingsEvent event, Emitter<SettingsStateState> emit) async {
    try {
      await prefs.setString('gender', event.gender);
      await prefs.setString('language', event.language);
      emit(SettingsLoaded(gender: event.gender, language: event.language));
    } catch (e) {
      emit(SettingsError(error: e.toString()));
    }
  }
}