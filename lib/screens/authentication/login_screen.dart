import 'package:edu_app/components/button.dart';
import 'package:edu_app/constants/constants.dart';
// import 'package:edu_app/constants/constants.dart';
import 'package:edu_app/controllers/auth_controllers.dart';
import 'package:edu_app/screens/authentication/create_account.dart';
import 'package:edu_app/screens/authentication/forgot_password.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool obsVal = true;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Welcome back",
                style: headingH1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Welcome back. Enter your credentials to access your account",
                style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Email Address",
                style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "hello@example.com",
                  hintStyle: GoogleFonts.dmSans(
                    color: Colors.grey.shade500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: HexColor("#EBEBF9")),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Password",
                style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: passwordController,
                obscureText: obsVal,
                decoration: InputDecoration(
                  // suffixIcon: IconButton(
                  //   icon: Icon(Icons.remove_red_eye_outlined),
                  //   color: Colors.grey.shade500,
                  //   onPressed: () {
                  //     // print(passwordController.text);
                  //     // setState(() {
                  //     //   obsVal = !obsVal;
                  //     // });
                  //   },
                  // ),
                  hintText: "Password",
                  hintStyle: GoogleFonts.dmSans(
                    color: Colors.grey.shade500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: HexColor("#EBEBF9")),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordRecovery(),
                        ));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.dmSans(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "Sign In",
                color: primaryColor,
                textColor: Colors.white,
                function: () {
                  AuthController.instance.login(emailController.text.trim(),
                      passwordController.text.trim());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or login with",
                        style: GoogleFonts.dmSans(color: Colors.black)),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconContainer(
                    'lib/assets/google.png',
                    () async {
                      await AuthController.instance.signInWithGoogle();
                    },
                  ),
                  IconContainer(
                    'lib/assets/facebook.png',
                    () {},
                  ),
                  IconContainer(
                    'lib/assets/apple.png',
                    () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: GoogleFonts.dmSans(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAccountScreen(),
                    ));
              },
              child: Text(
                "Sign up here ",
                style: GoogleFonts.dmSans(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget IconContainer(String path, Function()? function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 60,
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          // decoration: BoxDecoration(color: Colors.blue),
          child: Image.asset(
            path,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
