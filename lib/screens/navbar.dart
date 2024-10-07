import 'package:edu_app/components/const.dart';
import 'package:edu_app/screens/home.dart';
import 'package:edu_app/screens/profile.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              size: 45,
              color: _selectedIndex == 0 ? txtColor : Colors.grey.shade500,
            ),
            label: 'Home',
            isSelected: _selectedIndex == 0,
            onTap: () => _onNavItemTapped(0),
            navi: const Homepage(),
          ),
          const SizedBox(
            width: 3,
          ),
          NavBarItem(
            icon: Icon(
              Icons.book,
              size: 45,
              color: _selectedIndex == 1 ? txtColor : Colors.grey.shade500,
            ),
            label: 'Courses',
            isSelected: _selectedIndex == 1,
            onTap: () => _onNavItemTapped(1),
            navi: Prflpage(),
          ),
          const SizedBox(
            width: 3,
          ),
          NavBarItem(
            icon: Icon(
              Icons.person,
              size: 45,
              color: _selectedIndex == 2 ? txtColor : Colors.grey.shade500,
            ),
            label: 'Profile',
            isSelected: _selectedIndex == 2,
            onTap: () => _onNavItemTapped(2),
            navi: Prflpage(),
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
  final navi;

  const NavBarItem({super.key, 
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.navi,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: () {
        onTap;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => (navi)),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 5),
          if (isSelected)
            Text(
              label,
              style: const TextStyle(fontSize: 18), // Increase the font size here
            ),
        ],
      ),
    );
  }
}
