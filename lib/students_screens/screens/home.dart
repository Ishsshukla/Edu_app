import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/models/new_page_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_notifier.dart';
import 'navbar.dart';

class Homepage extends StatefulWidget {
  final String docIdUser;
  const Homepage({super.key, required this.docIdUser});

  @override
  _HomepageState createState() => _HomepageState();
}

TextEditingController _controller = TextEditingController();

class _HomepageState extends State<Homepage> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  TextEditingController _controller = TextEditingController();
  String? userName; // To store the user's name
  bool isLoading = true; // To show loading state while fetching data

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the page is initialized
    _pageController = PageController(initialPage: _currentPage);

    // Set up the timer to change the page every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      // Safely animate to the next page
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
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
  void dispose() {
    // Dispose of the timer and page controller
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final userNotifier = Provider.of<UserNotifier>(context);
    NewsViewModel newsViewModel = NewsViewModel();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: isLoading 
        ? const CircularProgressIndicator()
        : Text( 
          userName != null ? "Hi, $userName": "Hi",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Add your desired functionality here
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  txt2(' What do you want to learn today ?', context),
                ],
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 10),

              // Automatic Horizontal Scrolling Cards
              SizedBox(
                height: 160, 
                width: 470,// Adjust height as needed
                child: Builder(builder: (BuildContext context) {
                  return PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _buildCard('assets/Mask Group.png', 'General Science', context),
                      _buildCard('assets/Mask Group2.png', 'Current Affairs', context),
                      _buildCard('assets/Mask Group2.png', 'Current Affairs', context),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Additional content (Latest Current Affairs)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  txt('  Latest Current Affairs', context),
                  GestureDetector(
                    onTap: () {
                      // Add your desired functionality here
                    },
                    child: txt('  ', context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Nav(initialIndex: 0,docIdUser: widget.docIdUser),
    );
  }

  // Helper function to build each card
  Widget _buildCard(String imagePath, String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(1),
              spreadRadius: 1.9,
              blurRadius: 7,
              offset: const Offset(0, 0),
              blurStyle: BlurStyle.inner,
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, scale: 3.2),
            txt2(title, context),
          ],
        ),
      ),
    );
  }
}

Widget txt2(String text, BuildContext context, {Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(color: color),
  );
}

Widget txt(String text, BuildContext context, {Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(color: color),
  );
}
