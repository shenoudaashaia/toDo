import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/auth/login_screen.dart';
import 'package:to_do_update/auth/user_provider.dart';
import 'package:to_do_update/firebase_function.dart';
import 'package:to_do_update/home_screen.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:to_do_update/tabs/tasks/default_elevated_bottom.dart';
import 'package:to_do_update/tabs/tasks/default_text_from_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_update/tabs/tasks/taskes_proider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDark = settingProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.createAccount,
          style: TextStyle(
            color: isDark ? Appthem.white : Appthem.black,
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
              DefaultTextFromField(
                controller: nameController,
                hintText: appLocalizations.name,
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return "name less than 3 characters";
                  }
                  return null;
                },
              ),
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
                lable: appLocalizations.createAccount,
                onPressed: register,
              ),
              SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName),
                child: Text(appLocalizations.alreadayhaveAndAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (globalKey.currentState!.validate()) {
      FirebaseFunction.register(
        name: nameController.text,
        password: passwordController.text,
        email: emailcontroller.text,
      ).then((user) {
        Provider.of<TaskesProider>(context, listen: false)
            .getUserName();
        Provider.of<UserProvider>(context, listen: false)
            .updateCurrentUser(user);
           
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
        String? massage;
        if (error is FirebaseAuthException) {
          massage = error.code;
        }
        Fluttertoast.showToast(
            msg: massage ?? "something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Appthem.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }
}
