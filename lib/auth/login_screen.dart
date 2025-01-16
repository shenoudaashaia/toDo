import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/auth/register_screen.dart';
import 'package:to_do_update/auth/user_provider.dart';
import 'package:to_do_update/firebase_function.dart';
import 'package:to_do_update/home_screen.dart';
import 'package:to_do_update/models/user_modle.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:to_do_update/tabs/tasks/default_elevated_bottom.dart';
import 'package:to_do_update/tabs/tasks/default_text_from_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_update/tabs/tasks/taskes_proider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDark = settingProvider.isDark;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.login,
          style: TextStyle(
            color: isDark ? Appthem.white : Appthem.black ,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              DefaultTextFromField(
                controller: emailcontroller,
                hintText: appLocalizations.email,
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return "eamil less than 5 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              DefaultTextFromField(
                controller: passwordController,
                hintText: appLocalizations.password,
                ispassword: true,
                validator: (value) {
                  if (value == null || value.trim().length < 8) {
                    return "password less than 8 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32,
              ),
              DefaultElevatedBottom(
                  lable: appLocalizations.login, onPressed:() {
                    login();
                  },),
              SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(RegisterScreen.routeName),
                child: Text(appLocalizations.dontHaveAndAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (globalKey.currentState!.validate()) {
      FirebaseFunction.login(
        email: emailcontroller.text,
        password: passwordController.text,
      ).then((user) { 
        Provider.of<TaskesProider>(context, listen: false)
            .getUserName();   
        Provider.of<UserProvider>(context, listen: false)
            .updateCurrentUser(user);
              Fluttertoast.showToast(
            msg:"something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Appthem.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
       print(error);
      
      });
    }
  }
}
