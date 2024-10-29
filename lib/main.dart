import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:edu_app/firebase_options.dart';
import 'package:edu_app/quiz/congo.dart';
import 'package:edu_app/quiz/quiz1.dart';
import 'package:edu_app/quiz/quiz_category.dart';
import 'package:edu_app/quiz/quiz_welcm_screen.dart';
import 'package:edu_app/students_screens/auth/emailOTPVerification.dart';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/auth/signup.dart';
import 'package:edu_app/students_screens/screens/course_fail.dart';
import 'package:edu_app/students_screens/screens/news.dart';
import 'package:edu_app/students_screens/screens/paysucess.dart';
import 'package:edu_app/students_screens/screens/privacypolicy.dart';
import 'package:edu_app/students_screens/screens/transaction_sucess.dart';
import 'package:edu_app/students_screens/screens/user_notifier.dart';
import 'package:edu_app/students_screens/upi/upi_screen.dart';
import 'package:edu_app/teacher_side/home.dart';
import 'package:edu_app/students_screens/counsellor_screen/home_counsellor.dart';

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
    return ChangeNotifierProvider(
      create: (context) => UserNotifier(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        getPages: [
          GetPage(name: '/upi_screen', page: () => const UpiScreen()),
          GetPage(
              name: '/otp_varification',
              page: () => const OTPVerificationEmail(
                    email: "yadavrahul818980@gmail.com",
                  )),
          GetPage(name: '/category_quiz', page: () => QuizCategoryScreen()),
          GetPage(name: '/welcm_quiz', page: () => WelcomeScreen()),
          GetPage(name: '/paysucess', page: () => const Paysucesspage()),
          GetPage(name: '/congo', page: () => const Congopage()),
          GetPage(
              name: '/transaction_sucess',
              page: () => const transactionpage(
                    userIdDoc: '',
                  )),
          GetPage(name: '/quiz', page: () => const QuizPage()),
          GetPage(name: '/coursefail', page: () => const CourseFailPage()),
          GetPage(name: '/privacy', page: () => const PrivacyPage()),
          GetPage(name: '/news', page: () => const Newspage()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignUpScreen()),
          GetPage(
              name: '/Thome',
              page: () => const teachHomepage(
                    docidUser: 'h',
                  )),
          GetPage(
              name: '/homecounsellor', page: () => HomeStudentCounsellor()),
        ],
      ),
    );
  }
}
