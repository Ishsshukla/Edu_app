import 'package:edu_app/components/const.dart';
import 'package:edu_app/quiz/quiz2.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Quiz'),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
                child: Center(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestionNumber.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                const Text(
                  ' of ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  totalNumberOfQuestions.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Image.asset('assets/quw.png', scale: 5),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                children: [
                  _buildAnswerButton(0, 'Answer 1', screenWidth),
                  SizedBox(width: screenWidth * 0.05),
                  _buildAnswerButton(1, 'Answer 2', screenWidth),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                children: [
                  _buildAnswerButton(2, 'Answer 3', screenWidth),
                  SizedBox(width: screenWidth * 0.05),
                  _buildAnswerButton(3, 'Answer 4', screenWidth),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            SizedBox(
              width: screenWidth * 0.9,
              height: screenHeight * 0.08,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizPage2(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: txtColor, // Change color as needed
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
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
        width: screenWidth * 0.4,
        height: 75,
        decoration: BoxDecoration(
          color: selectedList[index] ? txtColor : Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: selectedList[index] ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
