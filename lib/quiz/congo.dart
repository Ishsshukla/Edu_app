// ignore_for_file: sort_child_properties_last

import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/students_screens/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Congopage extends StatefulWidget {
  const Congopage({super.key});

  @override
  State<Congopage> createState() => _CongopageState();
}

class _CongopageState extends State<Congopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Container(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 140),
                Image.asset(
                  'assets/congo.png',
                  scale: 5,
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 80),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomButton(
                    text: 'Back to Home',
                    color: txtColor,
                    textColor: Colors.white,
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homepage(),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(color: Colors.black),
                const SizedBox(height: 15), // Adjust the spacing as needed
                const Text(
                  'Share Now !',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 1, 1),
                    letterSpacing: 1.0,
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'poppins',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/whatsapp.png',
                            scale: 8,
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(50, 50),
                            backgroundColor: txtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/instagram.png',
                            scale: 4.5,
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(50, 50),
                            backgroundColor: txtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/facebook-app-symbol.png',
                            scale: 8,
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(50, 50),
                            backgroundColor: txtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .18,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/twitter.png',
                            scale: 8,
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(50, 50),
                            backgroundColor: txtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
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
