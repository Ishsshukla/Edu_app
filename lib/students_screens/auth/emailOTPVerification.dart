// import 'dart:async';

// import 'package:edu_app/screens/authentication/reset_password.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:edu_app/components/custom_button.dart';
// import 'package:edu_app/constants/constants.dart';
// // import 'package:edu_app/screens/authentication_screens/reset_password.dart';

// class OTPVerification extends StatefulWidget {
//   final String email;
//   const OTPVerification({super.key, required this.email});

//   @override
//   State<OTPVerification> createState() => _OTPVerificationState();
// }

// class _OTPVerificationState extends State<OTPVerification> {
//   int _timerCount = 20;
//   Timer? _timer;
//   Widget continueAlias = Container();
//   final formKey = GlobalKey<FormState>();
//   TextEditingController textEditingController = TextEditingController();

//   // ignore: close_sinks
//   StreamController<ErrorAnimationType>? errorController;
//   @override
//   void initState() {
//     errorController = StreamController<ErrorAnimationType>();
//     startTimer();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     errorController!.close();
//     _timer?.cancel();
//     super.dispose();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_timerCount > 0) {
//           _timerCount--;
//         } else {
//           _timer?.cancel();
//         }
//       });
//     });
//   }

//   void resendOtp() {
//     // Implement your logic to resend OTP
//     setState(() {
//       _timerCount = 20;
//       startTimer();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: Text(
//           "Email Varification",
//           style: headingH3,
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Authentication code",
//                 style: headingH1,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "We have sent a verification code to your mail ${widget.email}",
//                 style: GoogleFonts.dmSans(
//                     color: textColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.normal),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Form(
//                 key: formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 8.0,
//                     horizontal: 20,
//                   ),
//                   child: PinCodeTextField(
//                     appContext: context,
//                     pastedTextStyle: TextStyle(
//                       color: primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     length: 6,

//                     animationType: AnimationType.slide,
//                     validator: (v) {
//                       if (v!.length < 6) {
//                         return "";
//                       } else {
//                         return null;
//                       }
//                     },
//                     pinTheme: PinTheme(
//                       activeColor: Colors.deepPurpleAccent,
//                       inactiveColor: Colors.deepPurpleAccent.shade400,
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(5),
//                       fieldHeight: 50,
//                       fieldWidth: 40,
//                       fieldOuterPadding: const EdgeInsets.all(3),
//                       activeFillColor: Colors.white,
//                     ),
//                     cursorColor: backgroundColor,

//                     showCursor: true,
//                     hapticFeedbackTypes: HapticFeedbackTypes.medium,
//                     animationDuration: const Duration(milliseconds: 300),
//                     enableActiveFill: false,

//                     errorAnimationController: errorController,
//                     controller: textEditingController,
//                     keyboardType: TextInputType.number,

//                     boxShadows: const [
//                       BoxShadow(
//                         offset: Offset(0, 1),
//                         color: Colors.black12,
//                         blurRadius: 10,
//                       )
//                     ],
//                     onCompleted: (v) {
//                       debugPrint("Completed");
//                       setState(() {
//                         continueAlias = CustomButton(
//                           text: "Submit",
//                           color: primaryColor,
//                           textColor: Colors.white,
//                           function: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const ResetPassword(),
//                                 ));
//                           },
//                         );
//                       });
//                     },
//                     // onTap: () {
//                     //   print("Pressed");
//                     // },
//                     onChanged: (value) {
//                       debugPrint(value);
//                       setState(() {
//                         var currentText = value;
//                       });
//                     },
//                     beforeTextPaste: (text) {
//                       debugPrint("Allowing to paste $text");
//                       print('167843');

//                       return true;
//                     },
//                   ),
//                 ),
//               ),
//               continueAlias,
//               const SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     (_timerCount > 0)
//                         ? Text(
//                             'Resend OTP in $_timerCount seconds',
//                             style: GoogleFonts.dmSans(
//                                 color: primaryColor,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         : TextButton(
//                             onPressed: () {},
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "I didn't recieve the code  ",
//                                   style:
//                                       GoogleFonts.dmSans(color: Colors.black),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     resendOtp();
//                                   },
//                                   child: Text(
//                                     "Resend",
//                                     style: GoogleFonts.dmSans(
//                                         color: primaryColor,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:edu_app/components/const.dart' as components;
import 'package:edu_app/constants/constants.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class OTPVerificationEmail extends StatefulWidget {
  final String email;

  const OTPVerificationEmail({super.key, required this.email});

  @override
  _OTPVerificationEmailState createState() => _OTPVerificationEmailState();
}

class _OTPVerificationEmailState extends State<OTPVerificationEmail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController otpController = TextEditingController();
  String? generatedOtp;
  bool isOtpSent = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    sendOtpToEmail(); // Automatically send OTP when the screen loads
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  // Step 2: Generate OTP
  String generateOtp() {
    final Random random = Random();
    String otp = '';
    for (int i = 0; i < 6; i++) {
      otp += random.nextInt(10).toString(); // Generate a 6-digit OTP
    }
    return otp;
  }

  // Step 3: Send OTP to Email using a package like 'mailer' (you can use any email service)
  Future<void> sendOtpToEmail() async {
    setState(() {
      loading = true;
    });

    generatedOtp = generateOtp(); // Generate the OTP

    // Use a package like 'mailer' to send OTP via email
    final smtpServer = gmail('sandeep70802475@gmail.com', 'viho rqjw sree syzk'); // Set up SMTP server with Gmail

    final message = Message()
      ..from = Address('sandeep70802475@gmail.com', 'Rahul')
      ..recipients.add(widget.email)
      ..subject = 'Your OTP Verification Code'
      ..text = 'Your OTP verification code is $generatedOtp';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      // Step 4: Store OTP and expiry in Firestore
      await _firestore.collection('otp_varification').doc(widget.email).set({
        'otp': generatedOtp,
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': DateTime.now().add(Duration(minutes: 5)),
        'verified': false, // OTP expiry time (5 minutes)
      });
      setState(() {
        isOtpSent = true;
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('OTP sent to your email!')));
    } catch (e) {
      print('Message not sent. Error: ' + e.toString());
      setState(() {
        loading = false;
      });
    }
  }

  // Step 5: Verify OTP
  Future<void> verifyOtp() async {
    if (otpController.text.isNotEmpty) {
      setState(() {
        loading = true;
      });
      try {
        // Fetch OTP from Firestore
        DocumentSnapshot otpDoc = await _firestore
            .collection('otp_varification')
            .doc(widget.email)
            .get();
        if (otpDoc.exists) {
          String storedOtp = otpDoc.get('otp');
          DateTime expiresAt = otpDoc.get('expiresAt').toDate();
          bool isVerified = otpDoc.get('verified');
          if (isVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('OTP has already been verified!')));
          } else if (DateTime.now().isBefore(expiresAt)) {
            if (storedOtp == otpController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OTP verified successfully!')));
                    // Update the verification status in Firestore
            await _firestore
                .collection('otp_varification')
                .doc(widget.email)
                .update({'verified': true});
                Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  SplashScreen(email: widget.email,)));
              // Navigate to a new screen or perform further actions here
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Invalid OTP!')));
            }
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('OTP expired!')));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No OTP found for this email!')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error verifying OTP: $e')));
      } finally {
        setState(() {
          loading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter the OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Verify Email",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A90E2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/DALL·E 2024-10-13 13.45.50 - A professional and visually engaging illustration for verifying email, designed for students, in a blue theme. The image features a dynamic, minimalis.webp', // Placeholder for email verification image
                fit: BoxFit.cover,
                width: double.infinity,
                height: screenHeight * 0.3, // Adjust the height as needed
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, screenWidth * 0.05, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter your OTP",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "A verification code has been sent to your email ${widget.email}. Please enter the code below to verify your email address.",
                      style: GoogleFonts.poppins(
                        color: components.textColor.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    if (isOtpSent)
                      Column(
                        children: [
                          TextField(
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.poppins(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: 'OTP Code',
                              labelStyle: GoogleFonts.poppins(color: Colors.black),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.black54), // Rectangular border
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          ElevatedButton(
                            onPressed: loading ? null : verifyOtp,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF4A90E2),
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                              minimumSize: Size.fromHeight(screenHeight * 0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadowColor: Colors.blueAccent,
                              elevation: 5,
                            ),
                            child: loading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  )
                                : Text(
                                    'Verify OTP',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (!isOtpSent && !loading)
                ElevatedButton(
                  onPressed: sendOtpToEmail,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF4A90E2),
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    minimumSize: Size.fromHeight(screenHeight * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.blueAccent,
                    elevation: 5,
                  ),
                  child: Text(
                    'Resend OTP',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (loading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}


