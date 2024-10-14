import 'package:edu_app/components/button.dart';
import 'package:edu_app/constants/constants.dart';
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

    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.1,
              ),
              Text(
                "Welcome back",
                style: headingH1,
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Text(
                "Welcome back. Enter your credentials to access your account",
                style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Text(
                "Email Address",
                style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: screenSize.width * 0.035,
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
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Text(
                "Password",
                style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: screenSize.width * 0.035,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: passwordController,
                obscureText: obsVal,
                decoration: InputDecoration(
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
              SizedBox(
                height: screenSize.height * 0.02,
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
                        fontSize: screenSize.width * 0.045,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
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
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
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
              SizedBox(
                height: screenSize.height * 0.02,
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
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: GoogleFonts.dmSans(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: screenSize.width * 0.04),
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
                    fontSize: screenSize.width * 0.04),
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
          child: Image.asset(
            path,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
