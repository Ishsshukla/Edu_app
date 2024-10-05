import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/firebase_options.dart';
import 'package:edu_app/quiz/quiz_category.dart';
import 'package:edu_app/students_screens/pages/user_notifier.dart';
import 'package:edu_app/students_screens/screens/class_options.dart';
import 'package:edu_app/quiz/congo.dart';
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
import 'package:edu_app/quiz/quiz1.dart';
import 'package:edu_app/students_screens/screens/review.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:edu_app/students_screens/screens/transaction_sucess.dart';
import 'package:edu_app/students_screens/upi/upi_screen.dart';
import 'package:edu_app/teacher_side/home.dart';
import 'package:edu_app/teacher_side/screens/Edit_course.dart';
import 'package:edu_app/teacher_side/screens/contenteditcourse.dart';
import 'package:edu_app/teacher_side/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'quiz/quiz_welcm_screen.dart';
import 'students_screens/auth/login.dart';
import 'students_screens/auth/signup.dart'; 
import 'students_screens/screens/splash2.dart';
import 'teacher_side/screens/course_screen.dart';

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
          GetPage(name: '/category_quiz', page: () => QuizCategoryScreen()),
          GetPage(name: '/welcm_quiz', page: () => WelcomeScreen()),
          GetPage(name: '/paysucess', page: () => const Paysucesspage()),
          GetPage(name: '/optionpage', page: () => const OptionPage()),
          GetPage(name: '/courseoptionpage', page: () => const courseoptionPage()),
          GetPage(name: '/homepage', page: () => const Homepage()),
          GetPage(name: '/profile', page: () => const Prflpage()),
          GetPage(name: '/congo', page: () => const Congopage()),
          GetPage(name: '/transaction_sucess', page: () => const transactionpage()),
          GetPage(name: '/review', page: () => Reviewpage()),
          GetPage(name: '/paymethod', page: () => const PayMethodPage()),
          GetPage(name: '/finalpay', page: () => Finalpaypage()),
          GetPage(name: '/coursedescr', page: () => CourseDescriptionpage()),
          GetPage(name: '/quiz', page: () => const QuizPage()),
          GetPage(name: '/coursefail', page: () => const CourseFailPage()),
          GetPage(name: '/privacy', page: () => const PrivacyPage()),
          GetPage(name: '/news', page: () => const Newspage()),
          GetPage(name: '/courseoption', page: () => const coursepage()),
          GetPage(name: '/enrolledcrspage', page: () => enrolledcrspage()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignUpScreen()),
          GetPage(name: '/splash2', page: () => SplashScreen2()),
          GetPage(name: '/phnhome', page: () => PhnHome()),
          GetPage(name: '/Thome', page: () => teachHomepage()),

          // teacherside
          GetPage(name: '/courseteacher', page: () => coursepageTeacher()),
         
          // GetPage(name: '/editcoursecontent', page: () =>  editcourseTeacher()),
          GetPage(name: '/editcourse', page: () => EditCourseDescriptionpage()),
        ],
      ),
    );
  }
}
