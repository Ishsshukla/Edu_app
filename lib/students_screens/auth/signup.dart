// import 'dart:js_interop';
import 'dart:ui';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edu_app/students_screens/widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../components/const.dart';
import '../screens/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  String email = "", password = "";
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  void registration() async {
    if (password != null && emailController.text != null) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Registration Successful',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              backgroundColor: txtColor,
            ),
          );
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'The password provided is too weak.',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                backgroundColor: txtColor,
              ),
            );
          }
        } else if (e.code == 'email-already-in-use') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'The account already exists for that email.',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                backgroundColor: txtColor,
              ),
            );
          }
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // void signUp() {
  //   setState(() {
  //     loading = true;
  //     _auth.createUserWithEmailAndPassword(
  //         email: emailController.text.toString(),
  //         password: passwordController.text.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_open)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Sign up',
              ontap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    email = emailController.text;
                    password = passwordController.text;
                  });
                }
                registration();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
