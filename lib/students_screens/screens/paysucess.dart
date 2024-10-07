// ignore_for_file: sort_child_properties_last

import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:flutter/material.dart';

class Paysucesspage extends StatefulWidget {
  const Paysucesspage({super.key});

  @override
  State<Paysucesspage> createState() => _PaysucessState();
}

class _PaysucessState extends State<Paysucesspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Container(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 140),
                Image.asset(
                  'assets/pay.png',
                  scale: 3.5,
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/tick.png',
                  scale: 5,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Congratulations !',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 1, 1),
                    letterSpacing: 1.0,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
                const Text(
                  ' You’ve Become a Member',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 1, 1),
                    letterSpacing: 1.0,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras netus mauris pulvinar suspendisse. Et sit ac lacus in rhoncus.'),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: CustomButton(
                    text: 'Back to Home',
                    color: const Color(0xFF4A90E2),
                    textColor: Colors.white,
                    function: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
