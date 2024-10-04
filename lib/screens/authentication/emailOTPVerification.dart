import 'dart:async';

import 'package:edu_app/screens/authentication/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:edu_app/components/custom_button.dart';
import 'package:edu_app/constants/constants.dart';
// import 'package:edu_app/screens/authentication_screens/reset_password.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  int _timerCount = 20;
  Timer? _timer;
  Widget continueAlias = Container();
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerCount > 0) {
          _timerCount--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void resendOtp() {
    // Implement your logic to resend OTP
    setState(() {
      _timerCount = 20;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: headingH3,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Authentication code",
                style: headingH1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We have sent a verification code to your mail rupeshyadav78857@gmail.com",
                style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30,
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,

                    animationType: AnimationType.slide,
                    validator: (v) {
                      if (v!.length < 6) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      activeColor: Colors.deepPurpleAccent,
                      inactiveColor: Colors.deepPurpleAccent.shade400,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      fieldOuterPadding: EdgeInsets.all(3),
                      activeFillColor: Colors.white,
                    ),
                    cursorColor: backgroundColor,

                    showCursor: true,
                    hapticFeedbackTypes: HapticFeedbackTypes.medium,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: false,

                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,

                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                      setState(() {
                        continueAlias = CustomButton(
                          text: "Submit",
                          color: primaryColor,
                          textColor: Colors.white,
                          function: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassword(),
                                ));
                          },
                        );
                      });
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        var currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      print('167843');

                      return true;
                    },
                  ),
                ),
              ),
              continueAlias,
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_timerCount > 0)
                        ? Text(
                            'Resend OTP in $_timerCount seconds',
                            style: GoogleFonts.dmSans(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        : TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "I didn't recieve the code  ",
                                  style:
                                      GoogleFonts.dmSans(color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    resendOtp();
                                  },
                                  child: Text(
                                    "Resend",
                                    style: GoogleFonts.dmSans(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
