// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class Newspage extends StatefulWidget {
  const Newspage({super.key});

  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.08, screenHeight * 0.02, screenWidth * 0.08, 0),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/Group287.png',
                      width: screenWidth * 0.3, // Adjust the width based on screen size
                    ),
                    const SizedBox(width: 10), // Add some spacing between the image and text
                    const Text('dgfdg'),
                  ],
                ),
              ],
              // crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        ),
      ),
    );
  }
}
