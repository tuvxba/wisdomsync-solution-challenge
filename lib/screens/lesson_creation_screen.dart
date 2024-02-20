import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'package:provider/provider.dart';
import '../token_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class LessonCreationScreen extends StatelessWidget {
  final Function(Lesson) onLessonCreated;

  LessonCreationScreen({Key? key, required this.onLessonCreated})
      : super(key: key);

  String title = '';
  String category = '';
  String lessonDescription = '';
  double lessonRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              context,
              label: 'Title',
              onChanged: (value) {
                title = value;
              },
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              context,
              label: 'Category',
              onChanged: (value) {
                category = value;
              },
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              context,
              label: 'Description',
              onChanged: (value) {
                lessonDescription = value;
              },
            ),
            const SizedBox(height: 32.0),
            _buildElevatedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context,
      {required String label, required ValueChanged<String> onChanged}) {
    return TextFormField(
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black87),
      maxLines: label == 'Description' ? 4 : 1,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.video,
            );

            if (result != null) {
              //ADDLATER
            } else {
              //ADDLATER
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.videocam,
                  size: 18.0,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Upload Video',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            if (_validateInput()) {
              Lesson createdLesson = Lesson(
                title: title,
                category: category,
                description: lessonDescription,
                rating: lessonRating,
              );

              onLessonCreated(createdLesson);
              Provider.of<TokenProvider>(context, listen: false)
                  .incrementUserTokens(20);
              Navigator.pop(context);
            } else {
              _showValidationWarning(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Lesson',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _validateInput() {
    return title.isNotEmpty &&
        category.isNotEmpty &&
        lessonDescription.isNotEmpty;
  }

  void _showValidationWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Validation Warning'),
          content: const Text('Please fill in all required fields.'),
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
}
