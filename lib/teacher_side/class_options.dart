import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:flutter/material.dart';

class teacherOptionPage extends StatefulWidget {
  const teacherOptionPage({super.key});

  @override
  State<teacherOptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<teacherOptionPage> {
  String selectedButton = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            crcl('Select the class you studying in', context),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.07, 0, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                      ),
                      Column(
                        children: [
                          Text(
                            'Class',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                      ),
                      Column(
                        children: [
                          Text(
                            'Class',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Next',
              color: txtColor,
              textColor: Colors.white,
              function: () {
                Navigator.pushNamed(context, 'courseoptionpage');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isSelected = selectedButton == text;

    return Container(
      height: screenHeight * 0.1, // Adjust height based on screen height
      width: screenWidth * 0.9, // Adjust width based on screen width
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? txtColor : Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedButton = text;
          });
          print('Selected: $text');
        },
        style: const ButtonStyle(),
        child: Text(
          text,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            color: isSelected ? txtColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
