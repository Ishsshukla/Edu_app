// // ignore_for_file: use_key_in_widget_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edu_app/components/button.dart';
// import 'package:edu_app/components/profie_text_edit.dart';
// import 'package:edu_app/screens/navbar.dart';
// import 'package:edu_app/teacher_side/navbar.dart';
// import 'package:flutter/material.dart';

// class Prflpage extends StatefulWidget {
//   final String docidUser;
//   Prflpage({super.key, required this.docidUser});
//   @override
//   State<Prflpage> createState() => _PrflpageState();
// }

// class _PrflpageState extends State<Prflpage> {
//   int? phoneNo;
//   String? email;
//   // String? password;

//   String? userName; // To store the user's name
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData(); // Fetch user data when the page is initialized
//   }

//   // Function to fetch user data from Firestore
//   Future<void> _fetchUserData() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.docidUser)
//           .get();
//       print(userDoc);
//       // Check if the document exists and get the 'name' field
//       if (userDoc.exists) {
//         setState(() {
//           userName = userDoc['name'] ?? '';
//           phoneNo = userDoc['phoneNo'] ?? '';
//           email = userDoc['email'] ?? '';
//           print("username==${userName}"); // Get the name from the document
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           userName = 'User not found';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         userName = 'Error fetching user';
//         isLoading = false;
//       });
//       print('Error fetching user data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     // final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//                 Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     MediaQuery.of(context).size.width * 0.25,
//                     10,
//                     0,
//                     20,
//                   ),
//                   child: Column(
//                     children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.05,
//                     ),
//                     Image.asset(
//                       'assets/profile.png',
//                       scale: MediaQuery.of(context).size.width * 0.01,
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.015,
//                     ),
//                     Text(
//                       'ishii',
//                       style: TextStyle(
//                       color: const Color.fromARGB(255, 17, 1, 1),
//                       letterSpacing: 1.0,
//                       fontSize: MediaQuery.of(context).size.width * 0.08,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'poppins',
//                       ),
//                     ),
//                     Text(
//                       '@ishi2048',
//                       style: TextStyle(
//                       color: const Color.fromARGB(255, 17, 1, 1),
//                       letterSpacing: 1.0,
//                       fontSize: MediaQuery.of(context).size.width * 0.04,
//                       fontWeight: FontWeight.normal,
//                       fontFamily: 'poppins',
//                       ),
//                     ),
//                     ],
//                   ),
//                   ),
//                 ],
//                 ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
//                     child: Column(
//                       children: [
//                         prflTxtEdit(
//                             Icons.near_me_rounded, 'Name', userName, context),
//                         const SizedBox(
//                           height: 0,
//                         ),
//                         prflTxtEdit(Icons.email, 'Email', email, context),
//                         const SizedBox(
//                           height: 0,
//                         ),
//                         // prflTxtEdit(Icons.lock_open_outlined, 'Password',
//                         //     '52535454436', context),
//                         // const SizedBox(
//                         //   height: 0,
//                         // ),
//                         prflTxtEdit(Icons.phone_android, 'Phone Number',
//                             "$phoneNo", context),
//                         const SizedBox(
//                           height: 0,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               CustomButton(
//                   text: 'Log Out',
//                   color: Colors.blue.shade700,
//                   textColor: Colors.white,
//                   function: () {})
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar:
//           NavTeacher(initialIndex: 2, docidUser: widget.docidUser),
//     );
//   }
// }


// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/profie_text_edit.dart';
// import 'package:edu_app/screens/authentication/login_screen.dart';
import 'package:edu_app/screens/navbar.dart';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/screens/privacypolicy.dart';
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
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
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
      body: isLoading // Show loader if data is still loading
          ? Center(
              child: CircularProgressIndicator(), // Loader
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 20),
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
                              Text(
                                '$userName',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 17, 1, 1),
                                  letterSpacing: 1.0,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              Text(
                                '$email',
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
                              prflTxtEdit(Icons.near_me_rounded, 'Name',
                                  userName, context),
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
                    // SizedBox(height: screenHeight * 0.03),
                    // const SizedBox(height: 40),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.security_rounded,
                            color: Color(0xFF4A90E2), size: 32),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF4A90E2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Perform logout logic here
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar:
          NavTeacher(initialIndex: 2, docidUser: widget.docidUser),
    );
  }
}
