import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quranapp/common/customFont.dart';

class VideoLessonsView extends StatelessWidget {
  final String title;
  final String subtitle;

  const VideoLessonsView({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: h1.copyWith(fontSize: 20.sp)), // Use ScreenUtil for font size
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quranic Lesson: $title',
              style: h1.copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold), // Use ScreenUtil for font size
            ),
            SizedBox(height: 16.h), // Use ScreenUtil for height spacing
            Text(
              subtitle,
              style: h4.copyWith(fontSize: 16.sp), // Use ScreenUtil for font size
            ),
            SizedBox(height: 16.h), // Use ScreenUtil for height spacing
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
