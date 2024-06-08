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
    // Add your phone number validation logic here
    // For example, you can check if the phone number has 10 digits
    return value.length == 10;
  }

  _signInWithMobileNumber() async {
    if (!_validatePhoneNumber(_phoneController.text.trim())) {
      // If phone number is not valid, show error message
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

    // Proceed with phone number verification
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + _phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          await _auth.signInWithCredential(authCredential).then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
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
              title: Text("Enter OTP"),
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
                              builder: (context) => SplashScreen()),
                        );
                      }
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  child: Text("Done"),
                )
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
        timeout: Duration(seconds: 45),
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
        title: Text(
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF7F7F7),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 100,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 104, horizontal: 64),
                        child: Text(
                          'Wait for Few seconds after entering your Phone Number',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF818181),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                      child: Text(
                        "You'll receive a 6-digit code to verify next.",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF818181),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Enter your Phone Number",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              _signInWithMobileNumber();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash Screen'),
      ),
      body: Center(
        child: Text('Splash Screen Content'),
      ),
    );
  }
}
