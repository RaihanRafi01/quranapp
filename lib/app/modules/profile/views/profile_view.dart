import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/common/appColors.dart';
import 'package:quranapp/common/widgets/customButton.dart';
import '../../../../common/customFont.dart';
import '../controllers/profile_controller.dart';
import 'profilePopUp.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: h3.copyWith(fontSize: 18.sp, color: AppColors.textBlue), // Responsive font size
                    ),
                    Text(
                      'Preview',
                      style: h3.copyWith(fontSize: 14.sp, color: AppColors.textBlue), // Responsive font size
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header Section
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(24.w), // Responsive padding
                    child: Column(
                      children: [
                        // Profile Avatar - Make it clickable
                        GestureDetector(
                          onTap: () => ProfilePopups.showAvatarPopup(context),
                          child: SvgPicture.asset(
                            'assets/images/settings/profile_icon.svg',
                            width: 80.w, // Responsive SVG width
                            height: 80.h, // Responsive SVG height
                          ),
                        ),
                        SizedBox(height: 16.h), // Responsive spacing
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100.w), // Responsive padding
                          child: CustomButton(
                            label: 'Share Profile',
                            onPressed: () {},
                            color: AppColors.btnClr4,
                            txtClr: AppColors.textColor,
                            width: double.infinity, // Full-width button
                            height: 50.h, // Responsive height
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h), // Responsive spacing

                  _buildTitle('Support Quranic Mastery'),

                  SizedBox(height: 8.h), // Responsive spacing

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
                    child: _buildMenuItem('', 'Invite Friends', false, () {
                      // Navigate to assignments
                    }, false, false),
                  ),

                  SizedBox(height: 8.h), // Responsive spacing

                  _buildTitle('Profile Settings'),

                  SizedBox(height: 8.h), // Responsive spacing

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.listClr,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)), // Responsive border radius
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem('assets/images/settings/user_icon.svg', 'Jamal', true, () {
                            ProfilePopups.showNameEditPopup(context);
                          }, true, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/venus-and-mars_icon.svg', 'Gender', true, () {
                            ProfilePopups.showGenderSelectionPopup(context);
                          }, true, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/mail_icon.svg', 'abc@email.com', true, () {
                            ProfilePopups.showEmailEditPopup(context);
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('', 'Change Password', false, () {
                            ProfilePopups.showPasswordChangePopup(context);
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('', 'Make Profile Private', false, () {
                            // Toggle privacy setting
                          }, false, true),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h), // Responsive spacing

                  _buildTitle('NOTIFICATIONS SETTINGS'),

                  SizedBox(height: 8.h), // Responsive spacing

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.listClr,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)), // Responsive border radius
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem('', 'Daily Notifications', false, () {
                            // Toggle daily notifications
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('', 'Reminder Time', false, () {
                            ProfilePopups.showTimeSelectionPopup(context);
                          }, false, false),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h), // Responsive spacing

                  _buildTitle('Study'),

                  SizedBox(height: 8.h), // Responsive spacing

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
                    child: _buildMenuItem('', 'My Daily Goal', false, () {
                      ProfilePopups.showDailyGoalPopup(context);
                    }, false, false),
                  ),

                  SizedBox(height: 8.h), // Responsive spacing

                  _buildTitle('SUBSCRIPTION'),

                  SizedBox(height: 8.h), // Responsive spacing

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
                    child: _buildMenuItem('', 'Manage Subscription', false, () {
                      // Navigate to subscription management
                    }, false, false),
                  ),

                  SizedBox(height: 8.h), // Responsive spacing

                  _buildTitle('OTHERS'),

                  SizedBox(height: 8.h), // Responsive spacing

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.listClr,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)), // Responsive border radius
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem('assets/images/settings/mail_icon.svg', 'Support', true, () {
                            // Navigate to support
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/messages_icon.svg', 'Discussion', true, () {
                            // Navigate to discussion
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/messages_icon.svg', 'WhatsNew', true, () {
                            // Navigate to what's new
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/globe_icon.svg', 'Website', true, () {
                            // Navigate to website
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/circle-help_icon.svg', 'Frequently Asked Questions', true, () {
                            // Navigate to FAQ
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/instagram_icon.svg', 'Instagram', true, () {
                            // Navigate to Instagram
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/globe_icon.svg', 'Terms of Use', true, () {
                            // Navigate to Terms of Use
                          }, false, false),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                            child: Divider(
                              height: 4.h, // Responsive height
                              color: AppColors.dividerClr,
                              thickness: 2.w, // Responsive thickness
                            ),
                          ),
                          _buildMenuItem('assets/images/settings/globe_icon.svg', 'Privacy Policy', true, () {
                            // Navigate to Privacy Policy
                          }, false, false),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 100.h), // Responsive spacing
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w), // Responsive padding
      child: Text(
        title,
        style: h3.copyWith(fontSize: 15.sp, color: AppColors.textBlue3), // Responsive font size
      ),
    );
  }

  Widget _buildMenuItem(
      String icon,
      String title,
      bool isIcon,
      VoidCallback onTap,
      bool isEdit,
      bool isToggle, {
        bool isDestructive = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.listClr,
        borderRadius: BorderRadius.all(Radius.circular(10.r)), // Responsive border radius
      ),
      child: ListTile(
        leading: isIcon
            ? SvgPicture.asset(
          icon,
          width: 24.w, // Responsive SVG width
          height: 24.h, // Responsive SVG height
        )
            : null,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp, // Responsive font size
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : Colors.black,
          ),
        ),
        trailing: isEdit
            ? Text(
          'Edit',
          style: h3.copyWith(
            fontSize: 14.sp, // Responsive font size
            color: AppColors.blurtext,
          ),
        )
            : isToggle
            ? Switch(
          activeColor: Colors.white,
          inactiveThumbColor: AppColors.textBlue,
          inactiveTrackColor: AppColors.btnClr2,
          activeTrackColor: AppColors.textBlue,
          value: true, // You may want to pass this as a parameter
          onChanged: (value) {
            onTap(); // Trigger onTap when toggle changes
          },
        )
            : Icon(
          Icons.arrow_forward_ios,
          size: 20.sp, // Responsive icon size
          color: AppColors.arrowClr,
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h), // Responsive padding
      ),
    );
  }
}