import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/components/profie_text_edit.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/firebase_services/database.dart';
import 'package:edu_app/students_screens/screens/navbar.dart';
import 'package:edu_app/students_screens/screens/privacypolicy.dart';
import 'package:edu_app/students_screens/firebase_services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../pages/user_notifier.dart';

class Prflpage extends StatefulWidget {
  const Prflpage({super.key});

  @override
  State<Prflpage> createState() => _PrflpageState();
}

class _PrflpageState extends State<Prflpage> {
  TextEditingController userfirstnamecontroller = TextEditingController();
  TextEditingController userlastnamecontroller = TextEditingController();
  TextEditingController useremailcontroller = TextEditingController();
  TextEditingController userphncontroller = TextEditingController();

  bool isEditingFirstName = false;
  bool isEditingLastName = false;
  bool isEditingEmail = false;
  bool isEditingPhn = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userData = await DatabaseMethods().getthisUserInfo(user.uid);
      setState(() {
        userfirstnamecontroller.text = userData['First Name'] ?? '';
        userlastnamecontroller.text = userData['Last Name'] ?? '';
        useremailcontroller.text = userData['email'] ?? '';
        userphncontroller.text = userData['phn'] ?? '';
      });

      Provider.of<UserNotifier>(context, listen: false).updateName(
          userData['First Name'] ?? '', userData['Last Name'] ?? '');
        }
  }

  Future<void> uploadData(String userId) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> uploaddata = {
        'First Name': userfirstnamecontroller.text,
        'Last Name': userlastnamecontroller.text,
        'email': useremailcontroller.text,
        'phn': userphncontroller.text,
      };

      await DatabaseMethods().updateUserDetails(uploaddata, userId);

      Provider.of<UserNotifier>(context, listen: false).updateName(
          userfirstnamecontroller.text, userlastnamecontroller.text);

      Fluttertoast.showToast(
        msg: "Data Saved Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: txtColor,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 45),
                      Image.asset('assets/profile.png', scale: 4.5),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '${userfirstnamecontroller.text} ${userlastnamecontroller.text}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      buildEditableField(
                        context,
                        "Your First Name",
                        userfirstnamecontroller,
                        isEditingFirstName,
                        () {
                          setState(() {
                            isEditingFirstName = !isEditingFirstName;
                            if (!isEditingFirstName) {
                              if (_formKey.currentState?.validate() ?? false) {
                                uploadData(
                                    FirebaseAuth.instance.currentUser!.uid);
                              }
                            }
                          });
                        },
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return 'First name can only contain letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      buildEditableField(
                        context,
                        "Your Last Name",
                        userlastnamecontroller,
                        isEditingLastName,
                        () {
                          setState(() {
                            isEditingLastName = !isEditingLastName;
                            if (!isEditingLastName) {
                              if (_formKey.currentState?.validate() ?? false) {
                                uploadData(
                                    FirebaseAuth.instance.currentUser!.uid);
                              }
                            }
                          });
                        },
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return 'Last name can only contain letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      buildEditableField(
                        context,
                        "Email",
                        useremailcontroller,
                        isEditingEmail,
                        () {
                          setState(() {
                            isEditingEmail = !isEditingEmail;
                            if (!isEditingEmail) {
                              if (_formKey.currentState?.validate() ?? false) {
                                uploadData(
                                    FirebaseAuth.instance.currentUser!.uid);
                              }
                            }
                          });
                        },
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      buildEditableField(
                        context,
                        "Phone Number",
                        userphncontroller,
                        isEditingPhn,
                        () {
                          setState(() {
                            isEditingPhn = !isEditingPhn;
                            if (!isEditingPhn) {
                              if (_formKey.currentState?.validate() ?? false) {
                                uploadData(
                                    FirebaseAuth.instance.currentUser!.uid);
                              }
                            }
                          });
                        },
                        icon: Icons.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
                  child: Row(
                    children: [
                      Icon(Icons.security_rounded, color: txtColor, size: 38),
                      const SizedBox(width: 24),
                      const Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPage(),
                            ),
                          );
                        },
                        child: Icon(Icons.arrow_forward_ios_rounded,
                            color: txtColor, size: 35),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Perform logout logic here
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: txtColor,
                        maximumSize: const Size(200, 1500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(150, 50)),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Nav(initialIndex: 2),
    );
  }

  Widget buildEditableField(
    BuildContext context,
    String hintText,
    TextEditingController controller,
    bool isEditing,
    VoidCallback onPressed, {
    required IconData icon,
    double iconSize = 32,
    required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Icon(icon, color: txtColor, size: iconSize),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 15.0),
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: txtColor,
                borderRadius: BorderRadius.circular(22),
              ),
              height: 70, // Set a fixed height to maintain consistency
              child: isEditing
                  ? TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: validator,
                    )
                  : Text(
                      controller.text.isEmpty ? hintText : controller.text,
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            color: txtColor,
            onPressed: () {
              if (isEditing) {
                if (_formKey.currentState?.validate() ?? false) {
                  onPressed();
                }
              } else {
                onPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}
