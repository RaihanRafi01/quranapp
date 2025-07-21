import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';

class ImportedLessonsView extends StatelessWidget {
  final String title;
  final String subtitle;

  const ImportedLessonsView({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textBlue2,
            size: 24.sp, // Responsive icon size
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          children: [
            Text(
              'Import Lesson',
              style: h1, // Uses h1 with fontSize: 24.sp
            ),
            SizedBox(height: 30.h), // Responsive spacing
            // Top 4 buttons grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16.w, // Responsive spacing
              crossAxisSpacing: 16.w, // Responsive spacing
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _ImportOption(icon: 'assets/images/lessons/url_icon.svg', label: 'Import By URL'),
                _ImportOption(icon: 'assets/images/lessons/scan_icon.svg', label: 'Scan to Import'),
                _ImportOption(icon: 'assets/images/lessons/text_icon.svg', label: 'Import Text'),
                _ImportOption(icon: 'assets/images/lessons/file_icon.svg', label: 'Import File'),
              ],
            ),
            SizedBox(height: 32.h), // Responsive spacing
            // Explanation Section
            Text(
              'Create Your Own Learning Content!',
              style: h1.copyWith(fontSize: 18.sp), // Responsive font size
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h), // Responsive spacing
            Text(
              'With our flexible import feature, you can turn your favorite content into learning material.\n\nOur AI will automatically detect words, generate vocabulary lists, exercises, and personalized lessons',
              textAlign: TextAlign.center,
              style: h3.copyWith(fontSize: 14.sp, height: 1.5), // Responsive font size
            ),
          ],
        ),
      ),
    );
  }
}

class _ImportOption extends StatelessWidget {
  final String icon;
  final String label;

  const _ImportOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.txtInput,
      borderRadius: BorderRadius.circular(16.r), // Responsive border radius
      child: InkWell(
        onTap: () {
          // Handle import action
        },
        borderRadius: BorderRadius.circular(16.r), // Responsive border radius
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w), // Responsive padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 48.w, // Responsive SVG width
                height: 48.h, // Responsive SVG height
              ),
              SizedBox(height: 18.h), // Responsive spacing
              Text(
                label,
                textAlign: TextAlign.center,
                style: h3.copyWith(fontSize: 16.sp), // Responsive font size
              ),
            ],
          ),
        ),
      ),
    );
  }
}