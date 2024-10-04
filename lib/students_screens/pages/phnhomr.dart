import 'package:edu_app/components/const.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhnHome extends StatefulWidget {
  const PhnHome({Key? key}) : super(key: key);

  @override
  State<PhnHome> createState() => _HomeState();
}

class _HomeState extends State<PhnHome> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codecontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String smscode = "";

  bool _validatePhoneNumber(String value) {
    return value.length == 10;
  }

  _signInWithMobileNumber() async {
    if (!_validatePhoneNumber(_phoneController.text.trim())) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid Phone Number"),
          content: Text("Please enter a valid 10-digit phone number."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + _phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          await _auth.signInWithCredential(authCredential).then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            );
          });
        },
        verificationFailed: ((error) {
          print(error);
        }),
        codeSent: (String verificationId, [int? forceResendingToken]) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text("Enter OTP"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _codecontroller,
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    smscode = _codecontroller.text;
                    PhoneAuthCredential _credential =
                        PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: smscode,
                    );
                    auth.signInWithCredential(_credential).then((result) {
                      if (result != null) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                        );
                      }
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  child: const Text("Done"),
                )
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
        timeout: const Duration(seconds: 45),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Continue with Phone Number",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF7F7F7),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                   const  Padding(
                      padding:  EdgeInsets.fromLTRB(30, 30, 15, 30),
                      child: Text(
                        'Wait for Few seconds after entering your Phone Number',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF818181),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Enter your Phone Number",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              _signInWithMobileNumber();
                            },
                            child: Container(
                              width: 220,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: txtColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child:const Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
                            child: Text(
                              "You'll receive a 6-digit code to verify next.",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF818181),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
