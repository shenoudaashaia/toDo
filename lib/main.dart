import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/auth/login_screen.dart';
import 'package:to_do_update/auth/register_screen.dart';
import 'package:to_do_update/home_screen.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:to_do_update/tabs/tasks/taskes_proider.dart';
import 'package:to_do_update/auth/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCpPH43aIJ2igESHFoJ32esL0IpSgTry40",
    appId: "1:216366023222:android:2d6dd0c50f652931534e97",
    messagingSenderId: "216366023222",
    projectId: "todo-6369b",
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskesProider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingProvider(),
        ),
      ],
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider=Provider.of<SettingProvider>(context);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: LoginScreen.routeName,
      theme: Appthem.lightTheme,
      themeMode: settingProvider.theme,
      darkTheme: Appthem.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settingProvider.locale,
    );
  }
}
