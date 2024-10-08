import 'package:edu_app/components/const.dart';
import 'package:edu_app/students_screens/screens/allcrs.dart';
import 'package:edu_app/students_screens/screens/crs_options.dart';
import 'package:edu_app/students_screens/screens/home.dart';
import 'package:edu_app/students_screens/screens/profile.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  final int initialIndex;

 const Nav({super.key, required this.initialIndex});

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  const CoursePageStudent()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Prflpage()),
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
              color: _selectedIndex == 0 ? const Color(0xFF4A90E2) : Colors.grey.shade500,
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
              color: _selectedIndex == 1 ? const Color(0xFF4A90E2) : Colors.grey.shade500,
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
              color: _selectedIndex == 2 ? const Color(0xFF4A90E2) : Colors.grey.shade500,
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

  const NavBarItem({super.key, 
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
                  fontSize: 15, color: Color(0xFF4A90E2)), // Ensure the text is blue
            ),
        ],
      ),
    );
  }
}
