import 'package:demo/provider/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return Stack(
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
                                'Select an Gender :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              RadioListTile<String>(
                                title: const Text('Female'),
                                value: 'Female',
                                autofocus: true,
                                groupValue: Provider.of<SettingsProvider>(context).pickedGender,
                                onChanged: (value) {
                                  settingsProvider.savePreferences('Female', settingsProvider.pickedGender);
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Male'),
                                value: 'Male',
                                groupValue: Provider.of<SettingsProvider>(context).pickedGender,
                                onChanged: (value) {
                                  settingsProvider.savePreferences('Male', settingsProvider.pickedGender);
                                },
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                          endIndent: 10,
                          indent: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              const Text(
                                'Select an Language :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              RadioListTile<String>(
                                title: const Text('Arabic'),
                                value: 'Arabic',
                                autofocus: true,
                                groupValue: Provider.of<SettingsProvider>(context).pickedLanguage,
                                onChanged: (value) {
                                  settingsProvider.savePreferences('Arabic', settingsProvider.pickedLanguage);
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('English'),
                                value: 'English',
                                groupValue: Provider.of<SettingsProvider>(context).pickedLanguage,
                                onChanged: (value) {
                                  settingsProvider.savePreferences('English', settingsProvider.pickedLanguage);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
