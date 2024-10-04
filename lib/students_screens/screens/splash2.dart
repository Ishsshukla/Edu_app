import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/students_screens/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen2> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 48), // Add padding here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Group 123.png'),
            const SizedBox(height: 56),
            SizedBox(
              width: 200, // Set the desired width
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras netus mauris pulvinar suspendisse. Et sit ac lacus in rhoncus.',
                style: TextStyle(fontSize: 20),
                overflow:
                    TextOverflow.ellipsis, // Truncate the text with ellipsis
                maxLines: 2, // Limit the text to 2 lines
              ),
            ),
            const SizedBox(height: 86), // Add desired height here
            CustomButton(
                text: "Let's Start Your Journey",
                color: txtColor,
                textColor: Colors.white,
                function: () {
                  Navigator.pushNamed(context, 'homepage');
                }),
          ],
        ),
      ),
    );
  }
}
