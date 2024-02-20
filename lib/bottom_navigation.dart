import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final ValueChanged<int> onTabSelected;

  const BottomNavigation({Key? key, required this.onTabSelected})
      : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.class_),
          label: 'Take',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        widget.onTabSelected(index);
      },
    );
  }
}
