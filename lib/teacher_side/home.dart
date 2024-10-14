import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/screens/news.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';

class teachHomepage extends StatefulWidget {
  final String docidUser;
  const teachHomepage({super.key, required this.docidUser});

  @override
  State<teachHomepage> createState() => _HomepageState();
}

TextEditingController _controller = TextEditingController();

class _HomepageState extends State<teachHomepage> {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hi ${userName ?? 'User'}',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 1, 1),
                letterSpacing: 1.0,
                fontSize: screenWidth * 0.065,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
              ),
            ),
            SizedBox(
              width: screenWidth * 0.18,
            ),
            Icon(
              Icons.notifications_rounded,
              color: Colors.grey,
              size: screenWidth * 0.09,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              Row(
                children: [
                  txt2(' What do you want to Teach today ?', context),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    buildCategoryCard('assets/Mask Group.png', 'General Science', screenWidth),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    buildCategoryCard('assets/Mask Group2.png', 'Current Affairs', screenWidth),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    buildCategoryCard('assets/Mask Group2.png', 'Current Affairs', screenWidth),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  txt('  Latest Current Affairs', context),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (const Newspage())),
                      );
                    },
                    child: txt('  See all', context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavTeacher(
        initialIndex: 0,
        docidUser: widget.docidUser,
      ),
    );
  }

  Widget buildCategoryCard(String imagePath, String title, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withOpacity(1),
            spreadRadius: 1.5,
            blurRadius: 7,
            offset: const Offset(0, 0),
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(imagePath, scale: 3.5),
          txt2(title, context),
        ],
      ),
    );
  }
}
