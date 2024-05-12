import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/screens.dart/class_options.dart';
import 'package:edu_app/screens.dart/congo.dart';
import 'package:edu_app/screens.dart/course_description.dart';
import 'package:edu_app/screens.dart/course_fail.dart';
import 'package:edu_app/screens.dart/course_options.dart';
import 'package:edu_app/screens.dart/final_pay.dart';
import 'package:edu_app/screens.dart/home.dart';
import 'package:edu_app/screens.dart/payment_method.dart';
import 'package:edu_app/screens.dart/profile.dart';
import 'package:edu_app/screens.dart/quiz.dart';
import 'package:edu_app/screens.dart/review.dart';
import 'package:edu_app/screens.dart/transaction_sucess.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/screens.dart/class_options.dart';
// import 'package:counsellor/components/home_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'coursefail',
      // initialRoute: 'subject_wise_attendance',
      routes: {
        'clstxt': (context) => optionpage(),
        'coursetxt': (context) => courseoptionpage(),
        'homepage': (context) => Homepage(),
        'profile': (context) => Prflpage(),
        'congo': (context) => Congopage(),
        'transaction_sucess': (context) => transactionpage(),
        'review': (context) => Reviewpage(),
        'paymethod': (context) => PayMethodPage(),
        'finalpay': (context) => Finalpaypage(),
        'coursedescr': (context) => CourseDescriptionpage(),
        'quiz': (context) => QuizPage(),
        'coursefail': (context) => CourseFailPage(),
      },
    );
  }
}
