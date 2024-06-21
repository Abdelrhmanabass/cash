import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Business Logic Layer/settings_state_bloc.dart';
import '../../core/lang/applocalization.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String _selectedLanguage = 'en';
  String _selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<SettingsStateBloc>(context).state;
    if (state is SettingsLoaded) {
      _selectedLanguage = state.language;
      _selectedGender = state.gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.translate('settings'),),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Home.jpg'),
                fit: BoxFit.cover,
              ),
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
                    offset: Offset(-4.0, -4.0),
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(18)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: Column(
                      children: [
                         Text(
                           AppLocalizations.of(context)!.translate('settings_change'),
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          value: _selectedLanguage,
                          items:  [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(AppLocalizations.of(context)!.translate('english')),
                            ),
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text(AppLocalizations.of(context)!.translate('arabic')),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedLanguage = value!;
                            });
                            BlocProvider.of<SettingsStateBloc>(context).add(
                              UpdateVoiceSettingsEvent(
                                language: _selectedLanguage,
                                gender: _selectedGender,
                              ),
                            );
                          },
                        ),
                       ...[RadioListTile<String>(
                            title: Text(AppLocalizations.of(context)!.translate('male')),
                            value: 'male',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                              BlocProvider.of<SettingsStateBloc>(context).add(
                                UpdateVoiceSettingsEvent(
                                  language: _selectedLanguage,
                                  gender: _selectedGender,
                                ),
                              );
                            },
                          ),
                          RadioListTile<String>(
                            title: Text(AppLocalizations.of(context)!.translate('female')),
                            value: 'female',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                              BlocProvider.of<SettingsStateBloc>(context).add(
                                UpdateVoiceSettingsEvent(
                                  language: _selectedLanguage,
                                  gender: _selectedGender,
                                ),
                              );
                            },
                          ),
                        ]
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
