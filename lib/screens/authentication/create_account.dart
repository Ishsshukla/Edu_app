import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:edu_app/components/custom_button.dart';
import 'package:edu_app/constants/constants.dart';
import 'package:edu_app/controllers/auth_controllers.dart';

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
                const ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Lorem ipsum dolor sit amet'),
                ),
                const ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Consectetur adipiscing elit'),
                ),
                const ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Sed do eiusmod tempor incididunt'),
                ),
                const ListTile(
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
    bool isChecked = true;
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "Create an Account",
                style: headingH1,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "We are happy to welcome you to this platform",
                style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: size.height * 0.05,
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
              SizedBox(
                height: size.height * 0.02,
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
              SizedBox(
                height: size.height * 0.02,
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
                    icon: const Icon(Icons.remove_red_eye_outlined),
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
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Material(
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        _showBottomSheet(context);
                        setState(() {
                          isChecked = value ?? false;
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
              SizedBox(
                height: size.height * 0.01,
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
              SizedBox(
                height: size.height * 0.01,
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
            vertical: size.height * 0.01, horizontal: padding),
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
