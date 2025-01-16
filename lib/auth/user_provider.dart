import 'package:flutter/material.dart';
import 'package:to_do_update/models/user_modle.dart';

class UserProvider extends ChangeNotifier{
  UserModle? currentuser;
   void updateCurrentUser(UserModle? user){
    currentuser=user;
    notifyListeners();
   }
}