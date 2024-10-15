import 'package:edu_app/components/button.dart';
import 'package:edu_app/constants/constants.dart';
import 'package:edu_app/controllers/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordRecovery extends StatelessWidget {
  PasswordRecovery({super.key});
  TextEditingController emailController = TextEditingController();
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: headingH3.copyWith(fontSize: screenWidth * 0.05),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                "Please enter your email",
                style: headingH1.copyWith(fontSize: screenWidth * 0.07),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                "We will send you a confirmation email",
                style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                "Email Address",
                style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "hello@example.com",
                  hintStyle: GoogleFonts.dmSans(
                    color: Colors.grey.shade500,
                    fontSize: screenWidth * 0.04,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: HexColor("#EBEBF9")),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              CustomButton(
                text: "Continue",
                color: primaryColor,
                textColor: Colors.white,
                function: () {
                  authController
                      .sendPasswordResetEmail(emailController.text.trim());
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
