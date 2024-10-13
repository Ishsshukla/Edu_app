import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/screens/authentication/phnhomr.dart';
import 'package:edu_app/students_screens/screens/class_options.dart';
import 'package:edu_app/students_screens/screens/home.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:edu_app/teacher_side/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../firebase_services/database.dart';
import '../widgets/round_button.dart';
import 'forgot_pw.dart';
import 'signup.dart';
import 'package:edu_app/students_screens/screens/profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "", password = "";
  bool loading = false;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle user login
  Future<void> userLogin() async {
    setState(() {
      loading = true;
    });
    try {
      // Authenticate the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user data from Firestore (user's role)
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      // Check if the user document exists and contains the 'role' field
      if (userDoc.exists && userDoc.data() != null) {
        String role = userDoc['role'];

        // Fetch OTP verification status from 'otp_verification' collection
        DocumentSnapshot otpDoc = await FirebaseFirestore.instance
            .collection('otp_varification')
            .doc(email) // Using email as the document ID
            .get();

        // Check if OTP is verified
        if (otpDoc.exists && otpDoc['verified'] == true) {
          // If OTP is verified, navigate based on role
          if (role == 'Student') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Homepage(), // Replace with student home screen widget
              ),
            );
          } else if (role == 'Teacher') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const teachHomepage(), // Replace with teacher home screen widget
              ),
            );
          } else {
            throw Exception('Invalid user role');
          }
        } else {
          // OTP is not verified
          throw Exception('OTP is not verified. Please verify your OTP.');
        }
      } else {
        throw Exception('User role not found');
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      } else {
        message = 'An error occurred: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  // Function to handle Google sign-in button click
  void handleGoogleBtnClick() async {
    try {
      await GoogleSignIn().signOut();
      UserCredential userCredential = await _signInWithGoogle();
      log('\nUser : ${userCredential.user}');
      log('\nuser: ${userCredential.additionalUserInfo}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SplashScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google: $e')),
      );
    }
  }

  // Function to handle Google sign-in
  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Screenshot 2024-10-13 141015.png', // Ensure the path is correct
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Welcome to SCF ',
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' Academy',
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Email',
                          prefixIcon: const Icon(Icons.email, color: Colors.black, size: 30.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: ' Enter Password',
                          prefixIcon: const Icon(Icons.lock_open, color: Colors.black, size: 30.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
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
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: const Text('Forgot Password?', style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 70),
                GestureDetector(
  child: ElevatedButton(
    onPressed: loading
        ? null
        : () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                email = emailController.text;
                password = passwordController.text;
                loading = true; // Start loading
              });
              userLogin();
            }
          },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A90E2), // Set the button color
      minimumSize: const Size(350, 60), // Set the button size directly
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: loading
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        : const Text(
            'Login',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
  ),
),

                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color(0xFF4A90E2), // Changed to blue to look clickable
                          decoration: TextDecoration.underline, // Underline to indicate clickability
                          fontWeight: FontWeight.bold, // Bold to make it more prominent
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Uncomment and implement Google sign-in if needed
                // InkWell(
                //   onTap: handleGoogleBtnClick,
                //   child: Container(
                //     height: 50,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
