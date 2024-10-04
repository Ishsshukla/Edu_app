import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:password_field_validator/password_field_validator.dart';
import 'package:edu_app/components/custom_button.dart';
import 'package:edu_app/constants/constants.dart';
import 'package:edu_app/controllers/auth_controllers.dart';
// import 'package:edu_app/screens/home_screen.dart/home_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = AuthController();
  bool obscureValue = true;

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          height: 350,
          child: Center(
            child: Column(
              children: [
                Text(
                  'Terms and Conditions!',
                  style: headingH3,
                ),
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Lorem ipsum dolor sit amet'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Consectetur adipiscing elit'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Sed do eiusmod tempor incididunt'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Ut labore et dolore magna aliqua'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isChecked = true;
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
                "Create an Account",
                style: headingH1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We are happy to welcome you to this platform",
                style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Full Name",
                style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Full Name",
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
                "Email Adress",
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
                obscureText: obscureValue,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {
                      setState(() {
                        obscureValue = !obscureValue;
                      });
                    },
                    color: Colors.grey.shade500,
                  ),
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
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: PasswordFieldValidator(
              //     minLength: 8,
              //     uppercaseCharCount: 1,
              //     lowercaseCharCount: 1,
              //     numericCharCount: 0,
              //     specialCharCount: 1,
              //     defaultColor: Colors.black,
              //     successColor: Colors.green,
              //     failureColor: Colors.red,
              //     controller: passwordController,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Material(
                    child: Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        _showBottomSheet(context);
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                  Text.rich(TextSpan(style: GoogleFonts.dmSans(), children: [
                    const TextSpan(
                        text: 'By creating an account, you agree to our\n'),
                    TextSpan(
                        text: 'Term and Conditions',
                        style: GoogleFonts.dmSans(
                            color: primaryColor, fontWeight: FontWeight.w600)),
                  ]))
                ],
              ),
              CustomButton(
                text: "Create Account",
                color: primaryColor,
                textColor: Colors.white,
                function: () {
                  print(nameController.text);
                  AuthController.instance.signUp(
                    nameController.text.trim(),
                    passwordController.text.trim(),
                    emailController.text.trim(),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                height: 10,
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
              onTap: () => Navigator.pop(context),
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
          padding: EdgeInsets.all(15),
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
