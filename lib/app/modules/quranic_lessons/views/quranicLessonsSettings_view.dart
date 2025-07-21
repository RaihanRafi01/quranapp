import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';

class QuranicLessonsSettingsView extends StatefulWidget {
  const QuranicLessonsSettingsView({super.key});

  @override
  State<QuranicLessonsSettingsView> createState() => _QuranicLessonsSettingsViewState();
}

class _QuranicLessonsSettingsViewState extends State<QuranicLessonsSettingsView> {
  // View Settings
  bool showArabic = true;
  bool showTranslation = true;
  bool showWordByWord = true;
  bool showTajweed = true;

  // Font Settings
  String selectedArabicFont = 'Arabic Font';
  String selectedTranslationFont = 'Classic Mutahharat';
  double arabicFontSize = 16;
  double translationFontSize = 14;

  // Translation Settings
  String selectedTranslation = 'Sahih International';
  String selectedWordByWord = 'Word by Word';
  String selectedTajweed = 'Classic Mutahharat Mushaf';

  // Font options
  final List<String> arabicFonts = [
    'Arabic Font',
    'Uthmanic Hafs',
    'Traditional',
    'Modern Arabic'
  ];

  final List<String> translationFonts = [
    'Classic Mutahharat',
    'Modern Sans',
    'Traditional Serif',
    'Clean Text'
  ];

  final List<String> translations = [
    'Sahih International',
    'Dr. Mustafa Khattab',
    'Abdullah Yusuf Ali',
    'Pickthall'
  ];

  final List<String> wordByWordOptions = [
    'Word by Word',
    'Detailed Analysis',
    'Simple Translation',
    'Grammar Focus'
  ];

  final List<String> tajweedOptions = [
    'Classic Mutahharat Mushaf',
    'Color Coded',
    'Simple Rules',
    'Advanced Tajweed'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            _buildAppBar(),

            // Settings Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w), // Use ScreenUtil for padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h), // ScreenUtil for height spacing

                    // View Section
                    _buildSectionTitle('View'),
                    SizedBox(height: 16.h), // ScreenUtil for height spacing
                    _buildCheckboxItem('Arabic', showArabic, (value) {
                      setState(() => showArabic = value!);
                    }),
                    _buildCheckboxItem('Translation', showTranslation, (value) {
                      setState(() => showTranslation = value!);
                    }),
                    _buildCheckboxItem('Word by Word', showWordByWord, (value) {
                      setState(() => showWordByWord = value!);
                    }),
                    _buildCheckboxItem('Tajweed', showTajweed, (value) {
                      setState(() => showTajweed = value!);
                    }),

                    SizedBox(height: 32.h), // ScreenUtil for height spacing

                    // Font Section
                    _buildSectionTitle('Font'),
                    SizedBox(height: 16.h), // ScreenUtil for height spacing
                    Text(
                      'Arabic Font',
                      style: h4.copyWith(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                      ),
                    ),
                    SizedBox(height: 4.h), // ScreenUtil for height spacing
                    Text(
                      'KFGQPC Hafs, Uthmani/Madani',
                      style: h4.copyWith(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        color: AppColors.textColor3,
                      ),
                    ),
                    SizedBox(height: 16.h), // ScreenUtil for height spacing
                    _buildFontSizeSlider('Arabic Font Size', arabicFontSize, (value) {
                      setState(() => arabicFontSize = value);
                    }),
                    _buildFontSizeSlider('Translation Font Size', translationFontSize, (value) {
                      setState(() => translationFontSize = value);
                    }),

                    SizedBox(height: 32.h), // ScreenUtil for height spacing

                    // Translations Section
                    _buildSubSection('Translations', '1 Selected'),
                    _buildSubSection('Word by Word', 'German'),
                    _buildSubSection('Mushaf Type', 'Classic Madani Mushaf'),
                    _buildSubSection('Tajweed Rules', 'Stops Signs, Tajweed Pronunciation Rules'),

                    SizedBox(height: 40.h), // ScreenUtil for height spacing
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubSection(String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: h4.copyWith(fontSize: 14.sp)), // Use ScreenUtil for font size
        SizedBox(height: 5.h), // ScreenUtil for height spacing
        Text(subTitle, style: h4.copyWith(fontSize: 14.sp, color: AppColors.textColor3)), // Use ScreenUtil for font size
        SizedBox(height: 25.h), // ScreenUtil for height spacing
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h), // Use ScreenUtil for padding
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 18.sp, color: Colors.black87), // Use ScreenUtil for icon size
            onPressed: () => Get.back(),
          ),
          Spacer(),
          Text(
            'Settings',
            style: h2.copyWith(
              fontSize: 18.sp, // Use ScreenUtil for font size
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          SizedBox(width: 40.w), // ScreenUtil for width spacing
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: h2.copyWith(
        fontSize: 20.sp, // Use ScreenUtil for font size
        color: AppColors.textColor2,
      ),
    );
  }

  Widget _buildCheckboxItem(String title, bool value, Function(bool?) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h), // Use ScreenUtil for margin
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.textBlue,
            checkColor: Colors.white,
            side: BorderSide(
              color: value ? AppColors.textBlue : Colors.grey[400]!,
              width: 2.w, // Use ScreenUtil for border width
            ),
          ),
          Text(
            title,
            style: h3.copyWith(
                fontSize: 14.sp, // Use ScreenUtil for font size
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeSlider(String title, double value, Function(double) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h), // Use ScreenUtil for margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: h4.copyWith(
                  fontSize: 14.sp, // Use ScreenUtil for font size
                ),
              ),
              Text(
                '${value.toInt()}',
                style: TextStyle(
                  fontSize: 14.sp, // Use ScreenUtil for font size
                  color: AppColors.textBlue2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h), // ScreenUtil for height spacing
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.textBlue,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: Colors.white,
              overlayColor: AppColors.textBlue.withOpacity(0.2),
              trackHeight: 4.h, // Use ScreenUtil for track height
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14.r), // Use ScreenUtil for thumb radius
            ),
            child: Slider(
              value: value,
              min: 10,
              max: 30,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
