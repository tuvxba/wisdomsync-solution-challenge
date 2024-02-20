import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/lesson_creation_screen.dart';
import 'theme/theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/taking_classes_screen.dart';
import 'screens/uploading_classes_screen.dart';
import 'screens/profile_screen.dart';
import 'token_provider.dart';
import 'models/lesson.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TokenProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: customTheme.copyWith(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 231, 137, 145),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/taking_classes': (context) => TakingClassesScreen(
              onLessonAdded: (Lesson lesson) {},
            ),
        '/uploading_classes': (context) => const UploadingClassesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/create_lesson': (context) => LessonCreationScreen(
              onLessonCreated: (Lesson lesson) {
                Navigator.pop(context);
              },
            ),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TakingClassesScreen(
      onLessonAdded: (Lesson lesson) {},
    ),
    const UploadingClassesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        },
      ),
    );
  }
}
