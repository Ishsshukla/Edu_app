import 'package:edu_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Congopage extends StatefulWidget {
  @override
  State<Congopage> createState() => _CongopageState();
}

class _CongopageState extends State<Congopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // const SizedBox(height: 160),
            Image.asset(
              'assets/congo.png',
              scale: 5,
            ),
            const SizedBox(height: 40),
            const Text(
              'Congratulations !',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 1, 1),
                letterSpacing: 1.0,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
              ),
            ),
            SizedBox(height: 80),
            CustomButton(
              text: 'Back to Home',
              color: Colors.blue,
              textColor: Colors.white,
              function: () {},
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 20), // Adjust the spacing as needed
            const Text(
              'Share !',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 1, 1),
                letterSpacing: 1.0,
                fontSize: 28,
                fontWeight: FontWeight.normal,
                fontFamily: 'poppins',
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: 'Button 1',
                  color: Colors.blue,
                  textColor: Colors.white,
                  function: () {},
                ),
                CustomButton(
                  text: 'Button 2',
                  color: Colors.blue,
                  textColor: Colors.white,
                  function: () {},
                ),
                CustomButton(
                  text: 'Button 3',
                  color: Colors.blue,
                  textColor: Colors.white,
                  function: () {},
                ),
                CustomButton(
                  text: 'Button 4',
                  color: Colors.blue,
                  textColor: Colors.white,
                  function: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
