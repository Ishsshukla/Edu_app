// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/profie_text_edit.dart';
import 'package:edu_app/screens/navbar.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';

class Prflpage extends StatefulWidget {
  final String docidUser;
  Prflpage({super.key, required this.docidUser});
  @override
  State<Prflpage> createState() => _PrflpageState();
}

class _PrflpageState extends State<Prflpage> {
  int? phoneNo;
  String? email;
  // String? password;

  String? userName; // To store the user's name
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the page is initialized
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.docidUser)
          .get();
      print(userDoc);
      // Check if the document exists and get the 'name' field
      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'] ?? '';
          phoneNo = userDoc['phoneNo'] ?? '';
          email = userDoc['email'] ?? '';
          print("username==${userName}"); // Get the name from the document
          isLoading = false;
        });
      } else {
        setState(() {
          userName = 'User not found';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Error fetching user';
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100.0, 10, 0, 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Image.asset(
                          'assets/profile.png',
                          scale: 4.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ishii',
                          style: TextStyle(
                            color: Color.fromARGB(255, 17, 1, 1),
                            letterSpacing: 1.0,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppins',
                          ),
                        ),
                        const Text(
                          '@ishi2048',
                          style: TextStyle(
                            color: Color.fromARGB(255, 17, 1, 1),
                            letterSpacing: 1.0,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                    child: Column(
                      children: [
                        prflTxtEdit(
                            Icons.near_me_rounded, 'Name', userName, context),
                        const SizedBox(
                          height: 0,
                        ),
                        prflTxtEdit(Icons.email, 'Email', email, context),
                        const SizedBox(
                          height: 0,
                        ),
                        // prflTxtEdit(Icons.lock_open_outlined, 'Password',
                        //     '52535454436', context),
                        // const SizedBox(
                        //   height: 0,
                        // ),
                        prflTxtEdit(Icons.phone_android, 'Phone Number',
                            "$phoneNo", context),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              CustomButton(
                  text: 'Log Out',
                  color: Colors.blue.shade700,
                  textColor: Colors.white,
                  function: () {})
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          NavTeacher(initialIndex: 2, docidUser: widget.docidUser),
    );
  }
}
