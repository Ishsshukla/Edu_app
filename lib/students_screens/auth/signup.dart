import 'package:edu_app/students_screens/auth/emailOTPVerification.dart';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:edu_app/students_screens/widgets/round_button.dart';
import 'package:edu_app/teacher_side/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

import '../../components/const.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String docidUser = '';
  bool loading = false;
  bool _obscureText = true;
  String email = "", password = "", name = "", phone = "";
  String? selectedRole;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance; // Initialize Firestore instance

  void registration() async {
    if (selectedRole != null) {
      setState(() {
        loading = true; // Show loader when registration starts
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Save additional user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'role': selectedRole,
          'createdAt': Timestamp.now(),
          'name': name,
          'phoneNo': phone,
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
            context, MaterialPageRoute(builder: (context) => OTPVerificationEmail(email: email)));
        }
        else{
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => teachHomepage(docidUser: '',)));
        }
      } on FirebaseAuthException catch (e) {
        String errorMsg = '';
        if (e.code == 'weak-password') {
          errorMsg = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMsg = 'The account already exists for that email.';
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMsg,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              backgroundColor: txtColor,
            ),
          );
        }
      } finally {
        setState(() {
          loading = false; // Hide loader after registration is complete
        });
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, screenHeight * 0.03, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/HeroImage.png',
                    width: screenWidth, // Full width
                    height: screenHeight * 0.54, // Adjust height
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: ' Name',
                              prefixIcon: Icon(Icons.person, color: Colors.black, size: 30),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: phoneController,
                            decoration: const InputDecoration(
                              hintText: ' Phone Number',
                              prefixIcon: Icon(Icons.phone, color: Colors.black, size: 30),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: ' Email',
                              prefixIcon: Icon(Icons.email, color: Colors.black, size: 30),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: ' Password',
                              prefixIcon: const Icon(Icons.lock_open, color: Colors.black, size: 30),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility : Icons.visibility_off,
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
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            selectedRole == null
                                ? 'Please select a role'
                                : 'Selected Role: $selectedRole',
                            style: TextStyle(
                              color: selectedRole == null ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        children: [
                          Text('Register '),
                          Text('as ? '),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.08),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      SizedBox(width: screenWidth * 0.08),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRole = 'Student';
                          });
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: selectedRole == 'Student' ? Color(0xFF4A90E2) : txtColor,
                              radius: screenWidth * 0.05,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            const Text(
                              'Student',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       selectedRole = 'Teacher';
                      //     });
                      //   },
                      //   child: Column(
                      //     children: [
                      //       CircleAvatar(
                      //         backgroundColor: selectedRole == 'Teacher' ? Color(0xFF4A90E2) : txtColor,
                      //         radius: screenWidth * 0.05,
                      //         child: const Icon(
                      //           Icons.school,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       SizedBox(height: screenHeight * 0.005),
                      //       const Text(
                      //         'Teacher',
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A90E2),
                        minimumSize: Size(screenWidth * 0.9, screenHeight * 0.08), // Set the button size directly
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ), // Button color
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() && selectedRole != null) {
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
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 29, // Increase font size
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
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
                          style: TextStyle(color: Color(0xFF4A90E2)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (loading)
            const Center(
              child: CircularProgressIndicator(), // Loader in the center of the screen
            ),
        ],
      ),
    );
  }
}
