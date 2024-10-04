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
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Image.asset('assets/crsfail.png', scale: 5),
            const SizedBox(height: 35),
            const Text('Oooops!  Sorry',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'poppins')),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
              child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Habitasse dolor etiam sed ante donec quis sapien?'),
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  _buildAnswerButton(0, 'Try Again'),
                  const SizedBox(height: 30),
                  _buildAnswerButton(1, 'Back to Home'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
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
        width: MediaQuery.of(context).size.width * 0.9,
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
