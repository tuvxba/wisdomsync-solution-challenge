import 'package:flutter/material.dart';

class _BottomNavigationBarScreen extends StatelessWidget {
  const _BottomNavigationBarScreen({
    Key? key,
    required this.currentIndex,
    required this.child,
  }) : super(key: key);

  final int currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.class_,
            ),
            label: 'Take',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/taking_classes');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/uploading_classes');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
