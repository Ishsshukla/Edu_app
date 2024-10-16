

// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/profie_text_edit.dart';
// import 'package:edu_app/screens/authentication/login_screen.dart';
import 'package:edu_app/screens/navbar.dart';
import 'package:edu_app/screens/privacypolicy.dart';
import 'package:edu_app/students_screens/auth/login.dart';
import 'package:edu_app/students_screens/firebase_services/database.dart';
import 'package:edu_app/students_screens/screens/user_notifier.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


// import 'user_notifier.dart';


class PrflpageT extends StatefulWidget {
  final String docIdUser;
  const PrflpageT({super.key, required this.docIdUser});

  @override
  State<PrflpageT> createState() => _PrflpageState();
}

class _PrflpageState extends State<PrflpageT> {
  TextEditingController userfirstnamecontroller = TextEditingController();
  TextEditingController userlastnamecontroller = TextEditingController();
  TextEditingController useremailcontroller = TextEditingController();
  TextEditingController userphncontroller = TextEditingController();

  bool isEditingFirstName = false;
  bool isEditingLastName = false;
  bool isEditingEmail = false;
  bool isEditingPhn = false;
  String? userName; // To store the user's name
  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    // loadUserProfile();
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.docIdUser)
          .get();
      print(userDoc);
      // Check if the document exists and get the 'name' field
      if (userDoc.exists) {
        setState(() {
          setState(() {
            userfirstnamecontroller.text = userDoc['name'] ?? '';
            useremailcontroller.text = userDoc['email'] ?? '';
            userphncontroller.text = userDoc['phoneNo'] ?? '';
          });
          userName = userDoc['name'];
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

  Future<void> uploadData(String userId) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> uploaddata = {
        'name': userfirstnamecontroller.text,
        'email': useremailcontroller.text,
        'phoneNO': userphncontroller.text,
      };

      await DatabaseMethods().updateUserDetails(uploaddata, userId);

      // Update user data in the notifier
      Provider.of<UserNotifier>(context, listen: false).updateName(
          userfirstnamecontroller.text, userlastnamecontroller.text);

      Fluttertoast.showToast(
        msg: "Data Saved Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: const Color(0xFF4A90E2),
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
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.04, // 4% of screen width
              screenHeight * 0.05, // 5% of screen height
              screenWidth * 0.04, // 4% of screen width
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.05), // 5% of screen height
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.13, // 13% of screen width
                      backgroundColor: Colors.grey[300],
                      backgroundImage: const AssetImage('assets/profile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Functionality to update profile image can be added here
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.05, // 5% of screen width
                          backgroundColor: const Color(0xFF4A90E2),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: screenWidth * 0.05, // 5% of screen width
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                Text(
                  '${userfirstnamecontroller.text} ${userlastnamecontroller.text}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06, // 6% of screen width
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4A90E2),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height
                buildEditableField(
                  context,
                  "Your Name",
                  userfirstnamecontroller,
                  isEditingFirstName,
                  () {
                    setState(() {
                      isEditingFirstName = !isEditingFirstName;
                      if (!isEditingFirstName) {
                        uploadData(FirebaseAuth.instance.currentUser!.uid);
                      }
                    });
                  },
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
              
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                buildEditableField(
                  context,
                  "Email",
                  useremailcontroller,
                  isEditingEmail,
                  () {
                    setState(() {
                      isEditingEmail = !isEditingEmail;
                      if (!isEditingEmail) {
                        uploadData(FirebaseAuth.instance.currentUser!.uid);
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
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                buildEditableField(
                  context,
                  "Phone Number",
                  userphncontroller,
                  isEditingPhn,
                  () {
                    setState(() {
                      isEditingPhn = !isEditingPhn;
                      if (!isEditingPhn) {
                        uploadData(FirebaseAuth.instance.currentUser!.uid);
                      }
                    });
                  },
                  icon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.05), // 5% of screen height
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.security_rounded,
                        color: const Color(0xFF4A90E2), size: screenWidth * 0.08), // 8% of screen width
                    SizedBox(width: screenWidth * 0.04), // 4% of screen width
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // 4.5% of screen width
                          color: const Color(0xFF4A90E2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05), // 5% of screen height
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
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08, // 8% of screen width
                          vertical: screenHeight * 0.02), // 2% of screen height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045, // 4.5% of screen width
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
      bottomNavigationBar:      
          NavTeacher(initialIndex: 2, docidUser: widget.docIdUser),
    );// Assuming `Nav` exists
  
  }


  Widget buildEditableField(
    BuildContext context,
    String labelText,
    TextEditingController controller,
    bool isEditing,
    VoidCallback onEditTap, {
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      enabled: isEditing, // Toggle between editable and non-editable
      decoration: InputDecoration(
        labelText: labelText,

        // suffixIcon: IconButton(
        //   icon: Icon(isEditing
        //       ? Icons.save
        //       : Icons.edit), // Toggle icon between edit and save
        //   onPressed: () {
        //     setState(() {
        //       onEditTap(); // Call the onEditTap function to toggle the editing state
        //     });
        //   },
        // ),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
      ),
      validator: validator,
    );
  }
}



