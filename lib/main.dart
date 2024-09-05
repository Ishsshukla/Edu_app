import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/controllers/auth_controllers.dart';
import 'package:edu_app/screens/class_options.dart';
import 'package:edu_app/screens/congo.dart';
import 'package:edu_app/screens/course.dart';
import 'package:edu_app/screens/course_description.dart';
import 'package:edu_app/screens/course_fail.dart';
import 'package:edu_app/screens/course_options.dart';
import 'package:edu_app/screens/final_pay.dart';
import 'package:edu_app/screens/firebase_options.dart';
import 'package:edu_app/screens/home.dart';
import 'package:edu_app/screens/news.dart';
import 'package:edu_app/screens/payment_method.dart';
import 'package:edu_app/screens/paysucess.dart';
import 'package:edu_app/screens/privacypolicy.dart';
import 'package:edu_app/screens/profile.dart';
import 'package:edu_app/screens/quiz.dart';
import 'package:edu_app/screens/review.dart';
import 'package:edu_app/screens/splash_screen.dart';
import 'package:edu_app/screens/transaction_sucess.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/screens/class_options.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:counsellor/components/home_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (value) {
      Get.put(AuthController());
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set status bar color to transparent
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      // initialRoute: 'subject_wise_attendance',
      routes: {
        'paysucess': (context) => Paysucesspage(),
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
        'coursefail': (context) => const CourseFailPage(),
        'privacy': (context) => const PrivacyPage(),
        'news': (context) => Newspage(),
        'courseoption': (context) => coursepage(),
        'splash': (context) => SplashScreen(),

      },
    );
  }
}
