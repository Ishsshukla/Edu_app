import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/screens.dart/class_options.dart';
import 'package:edu_app/screens.dart/congo.dart';
import 'package:edu_app/screens.dart/course_options.dart';
import 'package:edu_app/screens.dart/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      initialRoute: 'congo',
      // initialRoute: 'subject_wise_attendance',
      routes: {
        'clstxt': (context) => optionpage(),
        'coursetxt': (context) => courseoptionpage(),
        // 'homepage': (context) => Homepage(),
        'profile': (context) => prflpage(),
        'congo': (context) => Congopage(),
      },
    );
  }
}
