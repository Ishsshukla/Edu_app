import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/students_screens/firebase_services/splash_services.dart';
import 'package:edu_app/students_screens/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen2 extends StatefulWidget {
  final String email;
  const SplashScreen2({super.key, required this.email});

  @override
  State<SplashScreen2> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen2> {
  // SplashServices splashScreen = SplashServices();
  String docId = '';
  @override
  void initState() {
    super.initState();
    // splashScreen.isLogin(context);
    fetchUserDocId(widget.email);
  }

  // Function to fetch the document ID based on the email
  Future<void> fetchUserDocId(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace 'users' with your collection name
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If the document is found, get the document ID
        setState(() {
          docId = querySnapshot.docs.first.id;
          print("Document ID: $docId");
        });
      } else {
        // Handle case where no document is found
        print('No user found with this email');
      }
    } catch (e) {
      print('Error fetching document ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 48), // Add padding here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Group 123.png'),
            const SizedBox(height: 56),
            const SizedBox(
              width: 200, // Set the desired width
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras netus mauris pulvinar suspendisse. Et sit ac lacus in rhoncus.',
                style: TextStyle(fontSize: 20),
                overflow:
                    TextOverflow.ellipsis, // Truncate the text with ellipsis
                maxLines: 2, // Limit the text to 2 lines
              ),
            ),
            const SizedBox(height: 86), // Add desired height here
            CustomButton(
                text: "Let's Start Your Journey",
                color: txtColor,
                textColor: Colors.white,
                function: () {
                  if (docId != null) {
                    // Navigate to the homepage with the docId
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Homepage(
                                  docIdUser: docId,
                                )));
                  } else {
                    print('Document ID not found');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
