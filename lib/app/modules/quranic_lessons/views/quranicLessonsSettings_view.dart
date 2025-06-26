import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // View Section
                    _buildSectionTitle('View'),
                    const SizedBox(height: 16),
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

                    const SizedBox(height: 32),

                    // Font Section
                    _buildSectionTitle('Font'),
                    const SizedBox(height: 16),
                    Text(
                      'Arabic Font',
                      style: h4.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'KFGQPC Hafs, Uthmani/Madani',
                      style: h4.copyWith(
                        fontSize: 16,
                        color: AppColors.textColor3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFontSizeSlider('Arabic Font Size', arabicFontSize, (value) {
                      setState(() => arabicFontSize = value);
                    }),
                    _buildFontSizeSlider('Translation Font Size', translationFontSize, (value) {
                      setState(() => translationFontSize = value);
                    }),

                    const SizedBox(height: 32),

                    // Translations Section
                    _buildSubSection('Translations', '1 Selected'),
                    _buildSubSection('Word by Word', 'German'),
                    _buildSubSection('Mushaf Type', 'Classic Madani Mushaf'),
                    _buildSubSection('Tajweed Rules', 'Stops Signs, Tajweed Pronunciation Rules'),

                    const SizedBox(height: 40),
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
        Text(title, style: h4.copyWith(fontSize: 14)),
        SizedBox(height: 5),
        Text(subTitle, style: h4.copyWith(fontSize: 14, color: AppColors.textColor3)),
        SizedBox(height: 25),
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black87),
            onPressed: () => Get.back(),
          ),
          const Spacer(),
          Text(
            'Settings',
            style: h2.copyWith(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 40), // Balance for back button
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: h2.copyWith(
        fontSize: 20,
        color: AppColors.textColor2,
      ),
    );
  }

  Widget _buildCheckboxItem(String title, bool value, Function(bool?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.textBlue,
            checkColor: Colors.white,
            side: BorderSide(
              color: value ? AppColors.textBlue : Colors.grey[400]!,
              width: 2,
            ),
          ),
          Text(
            title,
            style: h3.copyWith(
              fontSize: 14,
              color: Colors.black
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeSlider(String title, double value, Function(double) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: h4.copyWith(
                  fontSize: 14,
                ),
              ),
              Text(
                '${value.toInt()}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textBlue2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.textBlue,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: Colors.white,
              overlayColor: AppColors.textBlue.withOpacity(0.2),
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
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