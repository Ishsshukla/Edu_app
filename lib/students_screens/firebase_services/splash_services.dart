import 'dart:async';

import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/screens/class_options.dart';
import 'package:flutter/material.dart';

import '../auth/signup.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    // Timer.run(() {});
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OptionPage()));
    });
  }
}
