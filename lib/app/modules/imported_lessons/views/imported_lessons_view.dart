import 'package:flutter/material.dart';
import 'package:quranapp/common/customFont.dart';

class ImportedLessonsView extends StatelessWidget {
  final String title;
  final String subtitle;

  const ImportedLessonsView({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: h1.copyWith(fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quranic Lesson: $title',
              style: h1.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: h4.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'This is the Quranic lesson content. Add your lesson details here.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}