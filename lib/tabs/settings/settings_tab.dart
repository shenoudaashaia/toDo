import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/auth/login_screen.dart';
import 'package:to_do_update/firebase_function.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class settingsTab extends StatelessWidget {
  const settingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDark = settingProvider.isDark;
    bool isEnglish = settingProvider.isEnglish;

    return Stack(children: [
      Container(
        height: screenHight * 0.17,
        width: double.infinity,
        color: Appthem.primary,
      ),
      PositionedDirectional(
        top: 20,
        start: 20,
        child: Text(
          appLocalizations.settings,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isDark ? Appthem.black : Appthem.white, fontSize: 22),
        ),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: screenHight * 0.20, horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Language",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isDark ? Appthem.white : Appthem.black,
                  ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Container(
                padding: EdgeInsetsDirectional.only(start: 8),
                height: 60,
                width: 300,
                decoration:
                    BoxDecoration(border: Border.all(color: Appthem.primary)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<bool>(
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(fontSize: 19, color: Appthem.primary),
                      value: isEnglish,
                      items: [
                        DropdownMenuItem(
                          value: true,
                          child: Text("English"),
                        ),
                        DropdownMenuItem(
                          value: false,
                          child: Text("Arabic"),
                        ),
                      ],
                      onChanged: (_) {
                        settingProvider.changeLanguage();
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "mode",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isDark ? Appthem.white : Appthem.black,
                  ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Container(
                padding: EdgeInsetsDirectional.only(start: 8),
                height: 60,
                width: 300,
                decoration:
                    BoxDecoration(border: Border.all(color: Appthem.primary)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<bool>(
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(fontSize: 19, color: Appthem.primary),
                      value: isDark,
                      items: [
                        DropdownMenuItem(
                          value: false,
                          child: Text("Light"),
                        ),
                        DropdownMenuItem(
                          value: true,
                          child: Text("dark"),
                        ),
                      ],
                      onChanged: (_) {
                        settingProvider.changeThemMode();
                      }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("logOut"),
                IconButton(
                  onPressed: () {
                    FirebaseFunction.logOut();
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  icon: Icon(Icons.logout_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
