import 'package:flutter/material.dart';

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarItem(
              image: Image.asset(
            'assets/home.png',
            scale: 2,
          )),
          NavBarItem(image: Image.asset('assets/course.png', scale: 2)),
          NavBarItem(image: Image.asset('assets/navprfl.png', scale: 2)),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final Image image;

  NavBarItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return image;
  }
}
