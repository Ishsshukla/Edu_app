// import 'package:edu_app/components/const.dart';
// import 'package:edu_app/students_screens/screens/allcrs.dart';
// import 'package:edu_app/students_screens/screens/crs_options.dart';
// import 'package:edu_app/students_screens/screens/home.dart';
// import 'package:edu_app/students_screens/screens/profile.dart';
// import 'package:flutter/material.dart';

// class Nav extends StatefulWidget {
//   final String docIdUser;
//   final int initialIndex;

//   const Nav({super.key, required this.initialIndex, required this.docIdUser});

//   @override
//   _NavState createState() => _NavState();
// }

// class _NavState extends State<Nav> {
//   late int _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.initialIndex;
//   }

//   void _onNavItemTapped(int index) {
//     if (_selectedIndex == index) return; // Avoid re-navigation to the same tab

//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => Homepage(
//                     docIdUser: widget.docIdUser,
//                   )),
//         );
//         break;
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) =>  CoursePageStudent(docIdUser: widget.docIdUser,)),
//         );
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => Prflpage(
//                     docIdUser: widget.docIdUser,
//                   )),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double iconSize = screenWidth * 0.1; // Adjust icon size based on screen width
//     double fontSize = screenWidth * 0.04; // Adjust font size based on screen width

//     return Container(
//       height: 70,
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           NavBarItem(
//             icon: Icon(
//               Icons.home,
//               size: iconSize,
//               color: _selectedIndex == 0
//                   ? const Color(0xFF4A90E2)
//                   : Colors.grey.shade500,
//             ),
//             label: 'Home',
//             isSelected: _selectedIndex == 0,
//             onTap: () => _onNavItemTapped(0),
//             fontSize: fontSize,
//           ),
//           const SizedBox(width: 3),
//           NavBarItem(
//             icon: Icon(
//               Icons.book,
//               size: iconSize,
//               color: _selectedIndex == 1
//                   ? const Color(0xFF4A90E2)
//                   : Colors.grey.shade500,
//             ),
//             label: 'Courses',
//             isSelected: _selectedIndex == 1,
//             onTap: () => _onNavItemTapped(1),
//             fontSize: fontSize,
//           ),
//           const SizedBox(width: 3),
//           NavBarItem(
//             icon: Icon(
//               Icons.person,
//               size: iconSize,
//               color: _selectedIndex == 2
//                   ? const Color(0xFF4A90E2)
//                   : Colors.grey.shade500,
//             ),
//             label: 'Profile',
//             isSelected: _selectedIndex == 2,
//             onTap: () => _onNavItemTapped(2),
//             fontSize: fontSize,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NavBarItem extends StatelessWidget {
//   final Icon icon;
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final double fontSize;

//   const NavBarItem({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//     required this.fontSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           icon,
//           const SizedBox(width: 5),
//           if (isSelected)
//             Text(
//               label,
//               style: TextStyle(
//                   fontSize: fontSize,
//                   color: const Color(0xFF4A90E2)), // Ensure the text is blue
//             ),
//         ],
//       ),
//     );
//   }
// }


import 'package:edu_app/components/const.dart';
import 'package:edu_app/students_screens/screens/allcrs.dart';
import 'package:edu_app/students_screens/screens/crs_options.dart';
import 'package:edu_app/students_screens/screens/home.dart';
import 'package:edu_app/students_screens/screens/profile.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  final String docIdUser;
  final int initialIndex;

  const Nav({super.key, required this.initialIndex, required this.docIdUser});

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onNavItemTapped(int index) {
    if (_selectedIndex == index) return; // Avoid re-navigation to the same tab

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Homepage(
                    docIdUser: widget.docIdUser,
                  )),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  CoursePageStudent(docIdUser: widget.docIdUser,)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Prflpage(
                    docIdUser: widget.docIdUser,
                  )),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarItem(
            icon: Icon(
              Icons.home,
              size: 40,
              color: _selectedIndex == 0
                  ? const Color(0xFF4A90E2)
                  : Colors.grey.shade500,
            ),
            label: 'Home',
            isSelected: _selectedIndex == 0,
            onTap: () => _onNavItemTapped(0),
          ),
          const SizedBox(width: 3),
          NavBarItem(
            icon: Icon(
              Icons.book,
              size: 40,
              color: _selectedIndex == 1
                  ? const Color(0xFF4A90E2)
                  : Colors.grey.shade500,
            ),
            label: 'Courses',
            isSelected: _selectedIndex == 1,
            onTap: () => _onNavItemTapped(1),
          ),
          const SizedBox(width: 3),
          NavBarItem(
            icon: Icon(
              Icons.person,
              size: 40,
              color: _selectedIndex == 2
                  ? const Color(0xFF4A90E2)
                  : Colors.grey.shade500,
            ),
            label: 'Profile',
            isSelected: _selectedIndex == 2,
            onTap: () => _onNavItemTapped(2),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final Icon icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 5),
          if (isSelected)
            Text(
              label,
              style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4A90E2)), // Ensure the text is blue
            ),
        ],
      ),
    );
  }
}