import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:flutter/material.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  String selectedButton = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            crcl('Select the class you studying in', context),
            const SizedBox(height: 40, width: double.infinity),
            buildButton('Elementary School', context),
            const SizedBox(height: 25),
            buildButton('Junior High School', context),
            const SizedBox(height: 25),
            buildButton('Senior High School', context),
            const SizedBox(height: 25),
            buildButton('college ', context),
            const SizedBox(height: 65),
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
    bool isSelected = selectedButton == text;
    return Container(
      height: 70, // Add desired height here
      width: 340, // Add desired width here
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
          // Add your desired action on click here (e.g., print message)
          print('Selected: $text');
        },
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return txtColor;
              }
              return Colors.black;
            },
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: isSelected ? txtColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
