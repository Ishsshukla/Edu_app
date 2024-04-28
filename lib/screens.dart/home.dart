import 'package:edu_app/components/learningbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 174, 237, 160),
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => profilepage()),
            //     );
            //   },

            // ),

            Text(
              'hiii ishii  ',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 1, 1),
                letterSpacing: 1.0,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
              ),
              // centerTitle: true,
            ),
            SizedBox(
              width: 45,
            ),
            Icon(
              Icons.notifications_rounded,
              color: Colors.brown,
              size: 29,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      // bottomNavigationBar: Nav(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => chatpage()),
      //     ); // Add your onPressed logic here
      //   },
      //   child: Image(
      //     image: AssetImage('assets/Girl waiting.png'),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   // position: FloatingActionButtonLocation.centerFloat,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  lrngboxtxt('asset/Mask Group.png', 'MATHEMATICS', context),
                  lrngboxtxt('asset/Mask Group.png', 'MATHEMATICS', context),
                  lrngboxtxt('asset/Mask Group.png', 'MATHEMATICS', context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
