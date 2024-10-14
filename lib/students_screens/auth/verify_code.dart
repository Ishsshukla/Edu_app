import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:untitled1/utils/utils.dart';

import '../firebase_services/post_screeen.dart';
import '../utils/utils.dart';
import '../widgets/round_button.dart';
// import 'RoundButton.dart';
// import '../../firebase_database/post_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '6 digit code'),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            RoundButton(
                title: 'Verify',
                ontap: () async {
                  setState(() {
                    loading = true;
                  });
                  final crendital = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationCodeController.text.toString());

                  try {
                    await auth.signInWithCredential(crendital);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
