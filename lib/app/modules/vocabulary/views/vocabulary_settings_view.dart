import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quranapp/app/modules/vocabulary/controllers/vocabulary_controller.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';

class VocabularySettingsView extends StatelessWidget {
  const VocabularySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Settings',
          style: h2.copyWith(
            color: Colors.black87,
            fontSize: 20.sp, // Use ScreenUtil for font size
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Done',
              style: h4.copyWith(
                color: AppColors.textBlue,
                fontSize: 18.sp, // Use ScreenUtil for font size
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        children: [
          Padding(
            padding: EdgeInsets.all(10.w), // Use ScreenUtil for padding
            child: Text(
              'Activities',
              style: h2.copyWith(
                color: AppColors.textColor3,
                fontSize: 20.sp, // Use ScreenUtil for font size
              ),
            ),
          ),
          Obx(() => _buildSettingTile(
            title: 'Theme',
            value: controller.isDarkTheme.value,
            onChanged: controller.toggleTheme,
          )),
          Obx(() => _buildSettingTile(
            title: 'Language',
            value: controller.isEnglish.value,
            onChanged: controller.toggleLanguage,
          )),
          Obx(() => _buildSettingTile(
            title: 'About',
            value: controller.showAbout.value,
            onChanged: controller.toggleAbout,
          )),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp, // Use ScreenUtil for font size
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            inactiveThumbColor: AppColors.textBlue,
            inactiveTrackColor: AppColors.btnClr2,
            activeTrackColor: AppColors.textBlue,
          ),
          SizedBox(width: 10.w), // Use ScreenUtil for spacing
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black45),
        ],
      ),
      onTap: () {
        // Optional: can use this to open a detail page
      },
    );
  }
}
