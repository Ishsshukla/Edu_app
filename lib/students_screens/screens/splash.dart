import 'package:edu_app/components/button.dart';
import 'package:edu_app/students_screens/firebase_services/splash_services.dart';
import 'package:edu_app/students_screens/screens/splash2.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String email;
  const SplashScreen({super.key, required this.email});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
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
            Image.asset('assets/Hero Image.png'),
            const SizedBox(height: 56),
            const SizedBox(
              width: 200, // Set the desired width
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras netus mauris pulvinar suspendisse. Et sit ac lacus in rhoncus.',
                style: TextStyle(fontSize: 20),
                overflow:
                    TextOverflow.ellipsis, // Truncate the text with ellipsis
                maxLines: 2, // Limit the text to 2 lines
              ),
            ),
            const SizedBox(height: 86),
            CustomButton(
                text: 'Next',
                color: const Color(0xFF4A90E2),
                textColor: Colors.white,
                function: () {
                  Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  SplashScreen2(email: widget.email,)));
                  // Navigator.pushNamed(context, 'splash2');
                })
          ],
        ),
      ),
    );
  }
}
