import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/common/appColors.dart';
import 'package:quranapp/common/widgets/customButton.dart';
import '../../../../common/customFont.dart';
import 'profile_view.dart';

class ProfilePopups {
  // Avatar Selection Popup
  static void showAvatarPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Responsive border radius
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w), // Responsive padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Avatar',
                  style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'assets/images/settings/cancel_icon.svg',
                    width: 24.w, // Responsive SVG width
                    height: 24.h, // Responsive SVG height
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h), // Responsive spacing
            ListTile(
              leading: Icon(Icons.photo_camera, color: Colors.grey, size: 24.sp), // Responsive icon size
              title: Text(
                'Take Photo',
                style: TextStyle(fontSize: 16.sp), // Responsive font size
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle take photo
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.grey, size: 24.sp), // Responsive icon size
              title: Text(
                'Choose from Library',
                style: TextStyle(fontSize: 16.sp), // Responsive font size
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle choose from library
              },
            ),
            SizedBox(height: 20.h), // Responsive spacing
          ],
        ),
      ),
    );
  }

  // Name Edit Popup
  static void showNameEditPopup(BuildContext context, {String currentName = 'Jamal'}) {
    TextEditingController nameController = TextEditingController(text: currentName);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Responsive border radius
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(24.w), // Responsive padding
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name',
                    style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/images/settings/cancel_icon.svg',
                      width: 24.w, // Responsive SVG width
                      height: 24.h, // Responsive SVG height
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Responsive spacing
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Jamal',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp), // Responsive font size
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                    borderSide: BorderSide(color: AppColors.textBlue, width: 1.w), // Responsive border width
                  ),
                ),
              ),
              SizedBox(height: 24.h), // Responsive spacing
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Change',
                  onPressed: () {
                    Navigator.pop(context);
                    // Handle name change
                  },
                  color: AppColors.btnClr1,
                  txtClr: AppColors.btnTxt1,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
              SizedBox(height: 20.h), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }

  // Email Edit Popup
  static void showEmailEditPopup(BuildContext context, {String currentEmail = 'abc@email.com'}) {
    TextEditingController emailController = TextEditingController(text: currentEmail);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Responsive border radius
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(24.w), // Responsive padding
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'E-Mail',
                    style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/images/settings/cancel_icon.svg',
                      width: 24.w, // Responsive SVG width
                      height: 24.h, // Responsive SVG height
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Responsive spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]), // Responsive font size
                  ),
                  SizedBox(height: 8.h), // Responsive spacing
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'abc@email.com',
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp), // Responsive font size
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: AppColors.textBlue, width: 1.w), // Responsive border width
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h), // Responsive spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Email',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]), // Responsive font size
                  ),
                  SizedBox(height: 8.h), // Responsive spacing
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'abc@email.com',
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp), // Responsive font size
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: AppColors.textBlue, width: 1.w), // Responsive border width
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h), // Responsive spacing
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Change',
                  onPressed: () {
                    Navigator.pop(context);
                    // Handle email change
                  },
                  color: AppColors.btnClr1,
                  txtClr: AppColors.btnTxt1,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
              SizedBox(height: 20.h), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }

  // Gender Selection Popup
  static void showGenderSelectionPopup(BuildContext context) {
    String selectedGender = 'Male'; // Default selection

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Responsive border radius
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(24.w), // Responsive padding
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Your Gender',
                    style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/images/settings/cancel_icon.svg',
                      width: 24.w, // Responsive SVG width
                      height: 24.h, // Responsive SVG height
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Responsive spacing
              RadioListTile<String>(
                title: Text(
                  'Male',
                  style: TextStyle(fontSize: 16.sp), // Responsive font size
                ),
                value: 'Male',
                groupValue: selectedGender,
                activeColor: AppColors.btnClr1,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text(
                  'Female',
                  style: TextStyle(fontSize: 16.sp), // Responsive font size
                ),
                value: 'Female',
                groupValue: selectedGender,
                activeColor: AppColors.btnClr1,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              SizedBox(height: 24.h), // Responsive spacing
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Change',
                  onPressed: () {
                    Navigator.pop(context);
                    // Handle gender change
                  },
                  color: AppColors.btnClr1,
                  txtClr: AppColors.btnTxt1,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
              SizedBox(height: 20.h), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }

  // Password Change Popup
  static void showPasswordChangePopup(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Responsive border radius
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(24.w), // Responsive padding
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password',
                    style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/images/settings/cancel_icon.svg',
                      width: 24.w, // Responsive SVG width
                      height: 24.h, // Responsive SVG height
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Responsive spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Password',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]), // Responsive font size
                  ),
                  SizedBox(height: 8.h), // Responsive spacing
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: AppColors.textBlue, width: 1.w), // Responsive border width
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h), // Responsive spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]), // Responsive font size
                  ),
                  SizedBox(height: 8.h), // Responsive spacing
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: AppColors.textBlue, width: 1.w), // Responsive border width
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h), // Responsive spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]), // Responsive font size
                  ),
                  SizedBox(height: 8.h), // Responsive spacing
                  TextField(
                    controller: currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '●●●●●●●●',
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp), // Responsive font size
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                        borderSide: BorderSide(color: AppColors.textBlue, width: 1.w), // Responsive border width
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h), // Responsive spacing
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Change',
                  onPressed: () {
                    Navigator.pop(context);
                    // Handle password change
                  },
                  color: AppColors.btnClr1,
                  txtClr: AppColors.btnTxt1,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
              SizedBox(height: 20.h), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }

  // Time Selection Popup (for Reminder Time)
  static void showTimeSelectionPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Responsive border radius
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w), // Responsive padding
        height: 300.h, // Responsive height
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Time',
                  style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'assets/images/settings/cancel_icon.svg',
                    width: 24.w, // Responsive SVG width
                    height: 24.h, // Responsive SVG height
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h), // Responsive spacing
            Expanded(
              child: Row(
                children: [
                  // Hours
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'H',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive font size
                        ),
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40.h, // Responsive item extent
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                if (index < 0 || index > 23) return null;
                                return Center(
                                  child: Text(
                                    index.toString().padLeft(2, '0'),
                                    style: TextStyle(fontSize: 20.sp), // Responsive font size
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Minutes
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'M',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive font size
                        ),
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40.h, // Responsive item extent
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                if (index < 0 || index > 59) return null;
                                return Center(
                                  child: Text(
                                    index.toString().padLeft(2, '0'),
                                    style: TextStyle(fontSize: 20.sp), // Responsive font size
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // AM/PM
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), // Responsive font size
                        ),
                        Expanded(
                          child: ListWheelScrollView(
                            itemExtent: 40.h, // Responsive item extent
                            children: [
                              Center(
                                  child: Text('AM', style: TextStyle(fontSize: 20.sp))), // Responsive font size
                              Center(
                                  child: Text('PM', style: TextStyle(fontSize: 20.sp))), // Responsive font size
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h), // Responsive spacing
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: 'Choose a Time',
                onPressed: () {
                  Navigator.pop(context);
                  // Handle time selection
                },
                color: AppColors.btnClr1,
                txtClr: AppColors.btnTxt1,
                width: double.infinity, // Full-width button
                height: 50.h, // Responsive height
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Daily Goal Selection Popup
  static void showDailyGoalPopup(BuildContext context) {
    String selectedGoal = '5 min'; // Default selection
    List<String> goals = ['1 min', '5 min', '10 min', '15 min', '20 min'];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Responsive border radius
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(24.w), // Responsive padding
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Goal',
                    style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/images/settings/cancel_icon.svg',
                      width: 24.w, // Responsive SVG width
                      height: 24.h, // Responsive SVG height
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Responsive spacing
              ...goals.map((goal) => RadioListTile<String>(
                title: Text(
                  goal,
                  style: TextStyle(fontSize: 16.sp), // Responsive font size
                ),
                value: goal,
                groupValue: selectedGoal,
                activeColor: AppColors.btnClr1,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value!;
                  });
                },
              )).toList(),
              SizedBox(height: 24.h), // Responsive spacing
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Change',
                  onPressed: () {
                    Navigator.pop(context);
                    // Handle goal change
                  },
                  color: AppColors.btnClr1,
                  txtClr: AppColors.btnTxt1,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
              SizedBox(height: 20.h), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }
}

// Extension to add popup methods to ProfileView
extension ProfileViewPopups on ProfileView {
  void showPopupsBasedOnMenuItem(BuildContext context, String menuTitle) {
    switch (menuTitle) {
      case 'Jamal':
        ProfilePopups.showNameEditPopup(context);
        break;
      case 'abc@email.com':
        ProfilePopups.showEmailEditPopup(context);
        break;
      case 'Gender':
        ProfilePopups.showGenderSelectionPopup(context);
        break;
      case 'Change Password':
        ProfilePopups.showPasswordChangePopup(context);
        break;
      case 'Reminder Time':
        ProfilePopups.showTimeSelectionPopup(context);
        break;
      case 'My Daily Goal':
        ProfilePopups.showDailyGoalPopup(context);
        break;
      default:
      // Handle other menu items or show a default popup
        break;
    }
  }
}