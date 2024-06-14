import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../core/constants.dart';
part 'settings_state_event.dart';
part 'settings_state_state.dart';

class SettingsStateBloc extends Bloc<SettingsStateEvent, SettingsStateState> {
  SettingsStateBloc() : super(SettingsStateInitial()) {
    on<SettingsStateEvent>((event, emit) {

        if(event is InitialSettingsStateEvent){

          if(prefs!.getString('lang') != null && prefs!.getString('gender') != null)
          {
            if(prefs!.getString('lang') == 'ar' && prefs!.getString('gender') == 'male'){
              emit(AppChangeLanguage(language: 'ar'));
              emit(AppChangeGender(gender: 'male'));
            }

            else if(prefs!.getString('lang') == 'ar' && prefs!.getString('gender') == 'female') {
              emit(AppChangeLanguage(language: 'ar'));
              emit(AppChangeGender(gender: 'female'));
            }

            else if(prefs!.getString('lang') == 'en' && prefs!.getString('gender') == 'male') {
              emit(AppChangeLanguage(language: 'en'));
              emit(AppChangeGender(gender: 'male'));
            }

            else if(prefs!.getString('lang') == 'en' && prefs!.getString('gender') == 'female') {
              emit(AppChangeLanguage(language: 'en'));
              emit(AppChangeGender(gender: 'female'));
            }
          }
        }

        else if (event is ArabicLanguageEvent && event is MaleGenderEvent) {
          prefs!.setString('lang', 'ar');
          prefs!.setString('gender', 'male');
          emit(AppChangeLanguage(language: 'ar'));
          emit(AppChangeGender(gender: 'male'));

        }
        else if (event is ArabicLanguageEvent && event is FemaleGenderEvent) {
          prefs!.setString('lang', 'ar');
          prefs!.setString('gender', 'female');
          emit(AppChangeLanguage(language: 'ar'));
          emit(AppChangeGender(gender: 'female'));

        }

        else if (event is EnglishLanguageEvent && event is MaleGenderEvent) {
          prefs!.setString('lang', 'en');
          prefs!.setString('gender', 'male');
          emit(AppChangeLanguage(language: 'en'));
          emit(AppChangeGender(gender: 'male'));

        }
        else if (event is EnglishLanguageEvent && event is FemaleGenderEvent) {
          prefs!.setString('lang', 'en');
          prefs!.setString('gender', 'female');
          emit(AppChangeLanguage(language: 'en'));
          emit(AppChangeGender(gender: 'female'));

        }

    });
  }
}
