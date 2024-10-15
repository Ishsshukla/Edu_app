import 'package:edu_app/components/const.dart';
import 'package:flutter/material.dart';

class CourseFailPage extends StatefulWidget {
  const CourseFailPage({super.key});

  @override
  _CourseFailPageState createState() => _CourseFailPageState();
}

class _CourseFailPageState extends State<CourseFailPage> {
  late List<bool> selectedList; // Use a list to track selection for each answer
  int currentQuestionNumber = 1;
  int totalNumberOfQuestions = 15;

  @override
  void initState() {
    super.initState();
    // Initialize the list with all answers unselected initially
    selectedList = List<bool>.filled(4, false);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.2),
            Image.asset('assets/crsfail.png', scale: 5),
            SizedBox(height: screenHeight * 0.05),
            const Text('Oooops!  Sorry',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'poppins')),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Habitasse dolor etiam sed ante donec quis sapien?'),
            ),
            SizedBox(height: screenHeight * 0.1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  _buildAnswerButton(0, 'Try Again', screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  _buildAnswerButton(1, 'Back to Home', screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text, double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Deselect all buttons
          for (int i = 0; i < selectedList.length; i++) {
            selectedList[i] = false;
          }
          // Select the tapped button
          selectedList[index] = true;
        });
      },
      child: Container(
        width: screenWidth * 0.9,
        height: 75,
        decoration: BoxDecoration(
          color: selectedList[index] ? txtColor : Colors.white,
          border: Border.all(
            color: txtColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: selectedList[index] ? Colors.white : txtColor,
            ),
          ),
        ),
      ),
    );
  }
}
