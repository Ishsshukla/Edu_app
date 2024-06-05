import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/components/profie_text_edit.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/firebase_services/database.dart';
import 'package:edu_app/students_screens/screens/navbar.dart';
import 'package:edu_app/students_screens/screens/privacypolicy.dart';
import 'package:edu_app/students_screens/firebase_services/shared_preferences.dart'; // Import the helper class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Prflpage extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    // loadUserProfile();
  }

  Future<void> uploadData(String userId) async {
    Map<String, dynamic> uploaddata = {
      'First Name': userfirstnamecontroller.text,
      'Last Name': userlastnamecontroller.text,
      'email': useremailcontroller.text,
      'phn': userphncontroller.text,
    };

    // Save data to Firestore with the user ID as the document ID
    await DatabaseMethods().updateUserDetails(uploaddata, userId);

    // Save data locally
    await SharedPreferencesHelper.saveUserProfile(uploaddata);

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                          if (!isEditingFirstName)
                            uploadData(FirebaseAuth.instance.currentUser!.uid);
                        });
                      },
                      icon: Icons.person,
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
                          if (!isEditingLastName)
                            uploadData(FirebaseAuth.instance.currentUser!.uid);
                        });
                      },
                      icon: Icons.person_outline,
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
                          if (!isEditingEmail)
                            uploadData(FirebaseAuth.instance.currentUser!.uid);
                        });
                      },
                      icon: Icons.email,
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
                          if (!isEditingPhn)
                            uploadData(FirebaseAuth.instance.currentUser!.uid);
                        });
                      },
                      icon: Icons.phone,
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
                    Text(
                      'Privacy Policy',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPage(),
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
                      MaterialPageRoute(builder: (context) => LoginScreen()),
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
      bottomNavigationBar: Nav(initialIndex: 2),
    );
  }

  Widget buildEditableField(
    BuildContext context,
    String hintText,
    TextEditingController controller,
    bool isEditing,
    VoidCallback onPressed, {
    required IconData icon,
    double iconSize = 32, // Default size is 28.0
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Icon(icon,
              color: txtColor, size: iconSize), // Added iconSize parameter
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
              child: isEditing
                  ? TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                    )
                  : Text(
                      controller.text,
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
          ),
          // SizedBox(width: 0),
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            color: txtColor,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
