import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/firebase_options.dart';
import 'package:edu_app/students_screens/screens/class_options.dart';
import 'package:edu_app/students_screens/screens/congo.dart';
import 'package:edu_app/students_screens/screens/crs.dart';
import 'package:edu_app/students_screens/screens/crs_description.dart';
import 'package:edu_app/students_screens/screens/course_fail.dart';
import 'package:edu_app/students_screens/screens/crs_options.dart';
import 'package:edu_app/students_screens/screens/enrollled_crs.dart';
import 'package:edu_app/students_screens/screens/final_pay.dart';
import 'package:edu_app/students_screens/screens/home.dart';
import 'package:edu_app/students_screens/screens/news.dart';
import 'package:edu_app/students_screens/pages/phnhomr.dart';
import 'package:edu_app/students_screens/screens/payment_method.dart';
import 'package:edu_app/students_screens/screens/paysucess.dart';
import 'package:edu_app/students_screens/screens/privacypolicy.dart';
import 'package:edu_app/students_screens/screens/profile.dart';
import 'package:edu_app/students_screens/screens/quiz1.dart';
import 'package:edu_app/students_screens/screens/review.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:edu_app/students_screens/screens/transaction_sucess.dart';
import 'package:edu_app/teacher_side/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:edu_app/students_screens/screens/class_options.dart';

import 'package:edu_app/teacher_side/class_options.dart';

import 'students_screens/auth/login.dart';
// import 'students_screens/auth/phoneno.dart';
import 'students_screens/auth/signup.dart';
import 'students_screens/screens/splash2.dart';

// import 'package:counsellor/components/home_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'profile',
      // initialRoute: 'subject_wise_attendance',
      routes: {
        'paysucess': (context) => Paysucesspage(),
        'optionpage': (context) => OptionPage(),
        'courseoptionpage': (context) => courseoptionPage(),
        'homepage': (context) => Homepage(),
        'profile': (context) => Prflpage(),
        'congo': (context) => Congopage(),
        'transaction_sucess': (context) => transactionpage(),
        'review': (context) => Reviewpage(),
        'paymethod': (context) => PayMethodPage(),
        'finalpay': (context) => Finalpaypage(),
        'coursedescr': (context) => CourseDescriptionpage(),
        'quiz': (context) => QuizPage(),
        'coursefail': (context) => const CourseFailPage(),
        'privacy': (context) => const PrivacyPage(),
        'news': (context) => Newspage(),
        'courseoption': (context) => coursepage(),
        'enrolledcrspage': (context) => enrolledcrspage(),
        // 'splash': (context) => SplashScreen(),
        // 'nav': (context) => Nav(),
        'login': (context) => LoginScreen(),
        'signup': (context) => SignUpScreen(),
        'splash2': (context) => SplashScreen2(),
        // 'phonenumber': (context) => LoginWithPhoneNumber(),
        'phnhome': (context) => PhnHome(),

        'clsoptions': (context) => teacherOptionPage(),
        'Thome': (context) => teachHomepage()
      },
    );
  }
}
