import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../token_provider.dart';
import 'profile_screen.dart';

class TakingClassesScreen extends StatefulWidget {
  final Function(Lesson) onLessonAdded;

  const TakingClassesScreen({Key? key, required this.onLessonAdded})
      : super(key: key);

  @override
  _TakingClassesScreenState createState() => _TakingClassesScreenState();
}

class _TakingClassesScreenState extends State<TakingClassesScreen> {
  late int userTokens;
  late List<Lesson> availableLessons;
  late List<Lesson> displayedLessons;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userTokens = Provider.of<TokenProvider>(context, listen: false).userTokens;
    availableLessons = [
      Lesson(
        title: 'Programming Basics',
        category: 'Programming',
        description: 'Learn the fundamentals of programming.',
        rating: 4.5,
        tokensRequired: 20,
        categoryIcon: Icons.code,
      ),
      Lesson(
        title: 'Spanish for Beginners',
        category: 'Language',
        tokensRequired: 15,
        categoryIcon: Icons.language,
        description: 'Begin your journey to learn Spanish.',
        rating: 4.2,
      ),
      Lesson(
        title: 'Photography Masterclass',
        category: 'Photography',
        tokensRequired: 25,
        categoryIcon: Icons.camera,
        description: 'Master the art of photography.',
        rating: 4.8,
      ),
      Lesson(
        title: 'Fitness Fundamentals',
        category: 'Fitness',
        tokensRequired: 18,
        categoryIcon: Icons.fitness_center,
        description: 'Get fit with essential fitness routines.',
        rating: 4.0,
      ),
    ];
    displayedLessons = List.from(availableLessons);
  }

  @override
  Widget build(BuildContext context) {
    userTokens = Provider.of<TokenProvider>(context).userTokens;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.monetization_on),
            const SizedBox(width: 5),
            Text(
              '$userTokens',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: _onSearchTextChanged,
              decoration: const InputDecoration(
                hintText: 'Search lessons',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                itemCount: displayedLessons.length,
                itemBuilder: (context, index) {
                  final lesson = displayedLessons[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: const Color.fromARGB(255, 247, 234, 238),
                    child: ListTile(
                      leading: Icon(lesson.categoryIcon),
                      title: Text(
                        lesson.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category: ${lesson.category}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Description: ${lesson.description}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 79, 78, 78),
                            ),
                          ),
                          Text(
                            'Rating: ${lesson.rating}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${lesson.tokensRequired} Tokens',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                _showBookingConfirmationDialog(lesson);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor,
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                              child: const Text(
                                'Book',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingConfirmationDialog(Lesson lesson) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Confirmation'),
          content: Text('Do you want to book ${lesson.title}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _bookLesson(lesson);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _bookLesson(Lesson lesson) {
    int tokensToDeduct = lesson.tokensRequired;
    if (userTokens >= tokensToDeduct) {
      tokensToDeduct -= lesson.tokensRequired;
      userTokens -= lesson.tokensRequired;
      Provider.of<TokenProvider>(context, listen: false)
          .updateUserTokens(userTokens);
      _showConfirmationDialog(lesson);
      widget.onLessonAdded(lesson);
    } else {
      _showInsufficientTokensDialog();
    }
  }

  void _navigateToProfileScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) => const ProfileScreen()),
    );
  }

  void _showConfirmationDialog(Lesson lesson) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Confirmation'),
          content: Text('You have booked ${lesson.title}!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showInsufficientTokensDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Insufficient Tokens'),
          content:
              const Text('You do not have enough tokens to book this lesson.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      displayedLessons = availableLessons
          .where((lesson) =>
              lesson.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }
}
