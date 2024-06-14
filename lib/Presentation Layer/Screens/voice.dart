import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Business Logic Layer/settings_state_bloc.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  String _selectedLanguage = 'en';
  String _selectedGender= 'male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body:
             Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Home.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140, left: 20, right: 8),
                  child: Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFBF5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(4.0, 4.0),
                          spreadRadius: 2,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0), // changes position of shadow
                          spreadRadius: 2, // Spread radius
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                    ),

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20,bottom: 30),
                          child: Column(
                            children: [
                              const Text(
                                'Apply Your Settings :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              RadioListTile<String>(
                                title: const Text('English'),
                                value: 'en',
                                autofocus: true,
                                groupValue: _selectedLanguage,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLanguage = value!;
                                  });
                                   BlocProvider.of<SettingsStateBloc>(context).
                                   add(EnglishLanguageEvent());
                                }
                              ),
                              RadioListTile<String>(
                                title: const Text('Arabic '),
                                value: 'ar',
                                groupValue: _selectedLanguage,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLanguage = value!;
                                });
                                  BlocProvider.of<SettingsStateBloc>(context).
                                  add(ArabicLanguageEvent());
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Male Voice'),
                                value: 'male',
                                autofocus: true,
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                  BlocProvider.of<SettingsStateBloc>(context).
                                  add(MaleGenderEvent());
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('English & Female Voice'),
                                value: 'female',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                  BlocProvider.of<SettingsStateBloc>(context).
                                  add(FemaleGenderEvent());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        );
  }
}
