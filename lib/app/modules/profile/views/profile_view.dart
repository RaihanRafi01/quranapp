import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/common/appColors.dart';
import 'package:quranapp/common/widgets/customButton.dart';
import '../../../../common/customFont.dart';
import '../controllers/profile_controller.dart';

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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style:
                          h3.copyWith(fontSize: 18, color: AppColors.textBlue),
                    ),
                    Text(
                      'Preview',
                      style:
                          h3.copyWith(fontSize: 14, color: AppColors.textBlue),
                    )
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
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Profile Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[100],
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blue[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: CustomButton(
                              label: 'Share Profile',
                              onPressed: () {},
                              color: AppColors.btnClr4,
                              txtClr: AppColors.textColor),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  _buildTitle('Support Quranic Mastery'),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildMenuItem('', 'Invite Friends', false, () {
                      // Navigate to assignments
                    }, false, false),
                  ),

                  const SizedBox(height: 8),

                  _buildTitle('Profile Settings'),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration:
                      BoxDecoration(color: AppColors.listClr,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          _buildMenuItem('assets/images/settings/user_icon.svg',
                              'Jamal', true, () {
                            // Navigate to favorites
                          }, true, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/venus-and-mars_icon.svg',
                              'Gender',
                              true, () {
                            // Navigate to downloads
                          }, true, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem('assets/images/settings/mail_icon.svg',
                              'abc@email.com', true, () {
                            // Navigate to downloads
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem('', 'Change Password', false, () {
                            // Navigate to downloads
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem('', 'Make Profile Private', false, () {
                            // Navigate to downloads
                          }, false, true),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  _buildTitle('NOTIFICATIONS SETTINGS'),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration:
                      BoxDecoration(color: AppColors.listClr,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          _buildMenuItem('', 'Daily Notifications', false, () {
                            // Navigate to favorites
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem('', 'Reminder Time', false, () {
                            // Navigate to downloads
                          }, false, false),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  _buildTitle('Study'),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildMenuItem('', 'My Daily Goal', false, () {
                      // Navigate to assignments
                    }, false, false),
                  ),

                  const SizedBox(height: 8),

                  _buildTitle('SUBSCRIPTION'),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildMenuItem('', 'Manage Subscription', false, () {
                      // Navigate to assignments
                    }, false, false),
                  ),

                  const SizedBox(height: 8),

                  _buildTitle('OTHERS'),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration:
                      BoxDecoration(color: AppColors.listClr,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          _buildMenuItem('assets/images/settings/mail_icon.svg',
                              'Support', true, () {
                            // Navigate to favorites
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/messages_icon.svg',
                              'Discussion',
                              true, () {
                            // Navigate to downloads
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/messages_icon.svg',
                              'What’s New',
                              true, () {
                            // Navigate to favorites
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/globe_icon.svg',
                              'Website',
                              true, () {
                            // Navigate to downloads
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/circle-help_icon.svg',
                              'Frequently Asked Questions',
                              true, () {
                            // Navigate to favorites
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/instagram_icon.svg',
                              'Instagram',
                              true, () {
                            // Navigate to downloads
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/globe_icon.svg',
                              'Terms of Use',
                              true, () {
                            // Navigate to favorites
                          }, false, false),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                                height: 4,
                                color: AppColors.dividerClr,
                                thickness: 2),
                          ),
                          _buildMenuItem(
                              'assets/images/settings/globe_icon.svg',
                              'Privacy Policy',
                              true, () {
                            // Navigate to downloads
                          }, false, false),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        title,
        style: h3.copyWith(fontSize: 15, color: AppColors.textBlue3),
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
      //color: AppColors.listClr,
      decoration:
          BoxDecoration(color: AppColors.listClr,borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        leading: isIcon ? SvgPicture.asset(icon) : null,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : Colors.black,
          ),
        ),
        trailing: isEdit
            ? Text(
                'Edit',
                style: h3.copyWith(
                  fontSize: 14,
                  color: AppColors.blurtext,
                ),
              )
            : isToggle
                ? Switch(
                    activeColor: Colors.white,
                    inactiveThumbColor: AppColors.textBlue,
                    inactiveTrackColor: AppColors.btnClr2,
                    activeTrackColor: AppColors.textBlue,
                    value: true,
                    // You may want to pass this as a parameter
                    onChanged: (value) {
                      onTap(); // Trigger onTap when toggle changes
                    },
                  )
                : Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColors.arrowClr,
                  ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
