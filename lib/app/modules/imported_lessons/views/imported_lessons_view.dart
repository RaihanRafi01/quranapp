import 'package:flutter/material.dart';
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.textBlue2,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Import Lesson',style: h1.copyWith(fontSize: 21),),
            SizedBox(height: 30,),
            // Top 4 buttons grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _ImportOption(icon: 'assets/images/lessons/url_icon.svg', label: 'Import By URL'),
                _ImportOption(icon: 'assets/images/lessons/scan_icon.svg', label: 'Scan to Import'),
                _ImportOption(icon: 'assets/images/lessons/text_icon.svg', label: 'Import Text'),
                _ImportOption(icon: 'assets/images/lessons/file_icon.svg', label: 'Import File'),
              ],
            ),
            const SizedBox(height: 32),

            // Explanation Section
            Text(
              'Create Your Own Learning Content!',
              style: h1.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'With our flexible import feature, you can turn your favorite content into learning material.\n\nOur AI will automatically detect words, generate vocabulary lists, exercises, and personalized lessons',
              textAlign: TextAlign.center,
              style: h3.copyWith(fontSize: 14, height: 1.5),
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
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          // Handle import action
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              const SizedBox(height: 18),
              Text(label, textAlign: TextAlign.center, style: h3.copyWith(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
