import 'package:edu_app/components/learningbox.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/screens.dart/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

TextEditingController _controller = TextEditingController();

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '   Hi ishii  ',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 1, 1),
                letterSpacing: 1.0,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
              ),
            ),

            // txt('what you want to learn today', context),
            SizedBox(
              width: 185,
            ),
            Icon(
              Icons.notifications_rounded,
              color: Colors.grey,
              size: 29,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: Nav(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Row(
                children: [
                  txt2(' What do you want to learn today ?', context),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              // txt('what you want to learn today', context),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // txt('what you want to learn today', context),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(1),
                            spreadRadius: 1.5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/Mask Group.png', scale: 3.5),
                          txt2('General Science', context),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(1),
                            spreadRadius: 1.5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/Mask Group2.png', scale: 3.5),
                          txt2('Current Affairs ', context),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(1),
                            spreadRadius: 1.5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/Mask Group2.png', scale: 3.5),
                          txt2('Current Affairs ', context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  txt('  Latest Current Affairs', context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
