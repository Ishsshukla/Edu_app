import 'dart:ui';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:edu_app/students_screens/widgets/round_button.dart';
import 'package:edu_app/teacher_side/home.dart';
import 'package:edu_app/teacher_side/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

import '../../components/const.dart';
import '../screens/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  bool _obscureText = true;
  String email = "", password = "";
  String? selectedRole;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore =
      FirebaseFirestore.instance; // Initialize Firestore instance

  void registration() async {
    if (selectedRole != null) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Save additional user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'role': selectedRole,
          'createdAt': Timestamp.now(),
        });

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
        if (selectedRole == 'Student') {
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SplashScreen()));
        }
        else{
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => teachHomepage()));
        }

       
       
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 33, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/HeroImage.png',
                scale: 4,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
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
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock_open),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        selectedRole == null
                            ? 'Please select a role'
                            : 'Selected Role: $selectedRole',
                        style: TextStyle(
                          color:
                              selectedRole == null ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    children: [
                      Text('Register '),
                      Text('as ? '),
                    ],
                  ),
                  const SizedBox(width: 30),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRole = 'Student';
                      });
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: selectedRole == 'Student'
                              ? Colors.blue
                              : txtColor,
                          radius: 20,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Student',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRole = 'Teacher';
                      });
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: selectedRole == 'Teacher'
                              ? Colors.blue
                              : txtColor,
                          radius: 20,
                          child: const Icon(
                            Icons.school,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Teacher',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: RoundButton(
                  title: 'Sign up',
                  ontap: () {
                    if (_formKey.currentState!.validate() &&
                        selectedRole != null) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      registration();
                    } else if (selectedRole == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Please select a role',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          backgroundColor: txtColor,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: txtColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
