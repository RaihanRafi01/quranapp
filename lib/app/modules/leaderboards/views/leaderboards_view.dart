import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../controllers/leaderboards_controller.dart';

class LeaderboardsView extends GetView<LeaderboardsController> {
  const LeaderboardsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LeaderboardsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Top leaderboard or placeholder
          Obx(() {
            final isFrankfurt = controller.selectedTab.value == 'Frankfurt';
            final isJamal = controller.selectedTab.value == 'Jamal';
            if (isFrankfurt || isJamal) {
              return _buildFrankfurtPlaceholder();
            } else {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.w), // Responsive padding
                child: controller.leaderboard.length < 3
                    ? const SizedBox.shrink()
                    : Column(
                  children: [
                    SafeArea(
                      child: Text(
                        'Leaderboard',
                        style: h2.copyWith(fontSize: 16.sp), // Responsive font size
                      ),
                    ),
                    SizedBox(
                      height: 200.h, // Responsive height
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: _buildTopUser(
                              rank: 3,
                              name: controller.leaderboard[2].name,
                              points: '${controller.leaderboard[2].points} pts',
                              avatar: controller.leaderboard[2].avatar,
                              height: 80.h, // Responsive height
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: _buildTopUser(
                              rank: 1,
                              name: controller.leaderboard[0].name,
                              points: '${controller.leaderboard[0].points} pts',
                              avatar: controller.leaderboard[0].avatar,
                              height: 100.h, // Responsive height
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: _buildTopUser(
                              rank: 2,
                              name: controller.leaderboard[1].name,
                              points: '${controller.leaderboard[1].points} pts',
                              avatar: controller.leaderboard[1].avatar,
                              height: 90.h, // Responsive height
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h), // Responsive spacing
                  ],
                ),
              );
            }
          }),

          // Location tabs
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), // Responsive padding
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab('Global', controller.selectedTab.value == 'Global', () {
                  controller.changeTab('Global');
                }),
                _buildTab('Germany', controller.selectedTab.value == 'Germany', () {
                  controller.changeTab('Germany');
                }),
                _buildTab('Frankfurt', controller.selectedTab.value == 'Frankfurt', () {
                  controller.changeTab('Frankfurt');
                }),
                _buildTab('Jamal', controller.selectedTab.value == 'Jamal', () {
                  controller.changeTab('Jamal');
                }),
              ],
            )),
          ),

          // Rankings list or fallback
          Expanded(
            child: Obx(() {
              final isFrankfurt = controller.selectedTab.value == 'Frankfurt';
              final isJamal = controller.selectedTab.value == 'Jamal';
              final hasEnoughUsers = controller.leaderboard.length > 3;

              if (isFrankfurt) {
                return _buildNotEnoughUsersMessage();
              }
              if (isJamal) {
                return _buildUser();
              }

              return Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w), // Responsive padding
                  itemCount: controller.leaderboard.length - 3,
                  itemBuilder: (context, index) {
                    final user = controller.leaderboard[index + 3];
                    return _buildRankingItem(
                      index + 4,
                      user.name,
                      '${user.points} pts',
                      user.avatar,
                      isCurrentUser: user.isCurrentUser,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTopUser({
    required int rank,
    required String name,
    required String points,
    required String avatar,
    double height = 80,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 100.h, // Responsive height
          width: 80.w, // Responsive width
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 80.w, // Responsive width
                height: 80.h, // Responsive height
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.clrGreen, width: 3.w), // Responsive border width
                ),
                child: CircleAvatar(
                  radius: 40.r, // Responsive radius
                  backgroundColor: Colors.grey[300],
                  backgroundImage: AssetImage(avatar),
                  onBackgroundImageError: (_, __) {},
                  child: Icon(Icons.person, color: Colors.grey, size: 40.sp), // Responsive icon size
                ),
              ),
              Positioned(
                bottom: 0,
                child: CircleAvatar(
                  radius: 12.r, // Responsive radius
                  backgroundColor: AppColors.clrGreen,
                  child: Text(
                    '$rank',
                    style: h1.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h), // Responsive spacing
        Text(name, style: h2.copyWith(fontSize: 13.sp)), // Responsive font size
        Text(points, style: h4.copyWith(fontSize: 13.sp)), // Responsive font size
      ],
    );
  }

  Widget _buildTab(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: h4.copyWith(
              fontSize: 14.sp, // Responsive font size
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.blueDeep : Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.h), // Responsive spacing
          Container(
            height: 2.h, // Responsive height
            width: 50.w, // Responsive width
            color: isSelected ? AppColors.blueDeep : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(int rank, String name, String points, String avatar, {bool isCurrentUser = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h), // Responsive margin
      padding: EdgeInsets.all(12.w), // Responsive padding
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.clrGreen : Colors.white,
        borderRadius: BorderRadius.circular(12.r), // Responsive border radius
      ),
      child: Row(
        children: [
          Text(rank.toString().padLeft(2, '0'), style: h1.copyWith(fontSize: 14.sp)), // Responsive font size
          SizedBox(width: 12.w), // Responsive spacing
          CircleAvatar(
            radius: 20.r, // Responsive radius
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(avatar),
            onBackgroundImageError: (_, __) {},
            child: Icon(Icons.person, color: Colors.grey, size: 20.sp), // Responsive icon size
          ),
          SizedBox(width: 12.w), // Responsive spacing
          Expanded(child: Text(name, style: h2.copyWith(fontSize: 14.sp))), // Responsive font size
          Text(points, style: h3.copyWith(fontSize: 14.sp)), // Responsive font size
        ],
      ),
    );
  }

  Widget _buildNotEnoughUsersMessage() {
    return Container(
      padding: EdgeInsets.all(20.w), // Responsive padding
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h), // Responsive spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/home/map_icon.svg', width: 24.w, height: 24.h), // Responsive SVG size
                  SizedBox(width: 10.w), // Responsive spacing
                  Text('Frankfurt', style: h4.copyWith(fontSize: 16.sp)), // Responsive font size
                ],
              ),
              GestureDetector(
                onTap: _showMoreOptionsBottomSheet,
                child: Text('Edit', style: h4.copyWith(fontSize: 16.sp)), // Responsive font size
              ),
            ],
          ),
          SizedBox(height: 30.h), // Responsive spacing
          Text(
            "Frankfurt doesn’t have enough Kalaam users yet.",
            style: h2.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black), // Responsive font size
          ),
          SizedBox(height: 12.h), // Responsive spacing
          Text(
            "Only 7 more users needed to unlock “Frankfurt” leaderboard. Winners get exclusive badges for their profile. Invite your friends to join and be part of this rewarding experience!",
            style: h4.copyWith(fontSize: 13.sp, color: Colors.grey[700]), // Responsive font size
          ),
          SizedBox(height: 16.h), // Responsive spacing
          CustomButton(
            label: 'Invite Friends',
            onPressed: () {
              _showInviteFriendsSheet();
            },
            color: AppColors.btnClr1,
            txtClr: AppColors.btnTxt1,
            width: double.infinity, // Full-width button
            height: 50.h, // Responsive height
          ),
        ],
      ),
    );
  }

  Widget _buildUser() {
    return Container(
      padding: EdgeInsets.all(20.w), // Responsive padding
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You haven't added any friends yet",
            style: h2.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black), // Responsive font size
          ),
          SizedBox(height: 20.h), // Responsive spacing
          Text(
            "Add some of your real-life friends and family to start competing!",
            style: h4.copyWith(fontSize: 13.sp, color: Colors.grey[700]), // Responsive font size
          ),
          SizedBox(height: 30.h), // Responsive spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _showInviteFriendsSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h), // Responsive padding
                    decoration: BoxDecoration(
                      color: AppColors.btnClr1,
                      borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Friends",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp, // Responsive font size
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w), // Responsive spacing
                        SvgPicture.asset('assets/images/settings/user_add_icon.svg',
                            width: 20.w, height: 20.h), // Responsive SVG size
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w), // Responsive spacing
              IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.blue, size: 24.sp), // Responsive icon size
                onPressed: _showMoreOptionsBottomSheet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMoreOptionsBottomSheet() {
    Get.back();
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r), // Responsive border radius
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 24.sp), // Responsive icon size
                        onPressed: () => Get.back(),
                      ),
                      Text(
                        "More Options",
                        style: h3.copyWith(fontSize: 20.sp, color: Colors.black), // Responsive font size
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/images/settings/cancel_icon.svg',
                        width: 24.w, height: 24.h), // Responsive SVG size
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: GestureDetector(
                  child: SvgPicture.asset('assets/images/settings/mail_icon.svg',
                      width: 24.w, height: 24.h)), // Responsive SVG size
              trailing: Icon(Icons.keyboard_arrow_right_rounded,
                  size: 30.sp, color: AppColors.arrowClr), // Responsive icon size
              title: Text("Rename Leaderboard",
                  style: h4.copyWith(fontSize: 16.sp, color: Colors.black)), // Responsive font size
              onTap: () {
                Get.back();
                _showRenameLeaderboardSheet();
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/settings/messages_icon.svg',
                  width: 24.w, height: 24.h), // Responsive SVG size
              trailing: Icon(Icons.keyboard_arrow_right_rounded,
                  size: 30.sp, color: AppColors.arrowClr), // Responsive icon size
              title: Text("Manage members",
                  style: h4.copyWith(fontSize: 16.sp, color: Colors.black)), // Responsive font size
              onTap: () {
                Get.back();
                _showManageMembersSheet();
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/settings/settings_icon.svg',
                  width: 24.w, height: 24.h), // Responsive SVG size
              trailing: Icon(Icons.keyboard_arrow_right_rounded,
                  size: 30.sp, color: AppColors.arrowClr), // Responsive icon size
              title: Text("Settings",
                  style: h4.copyWith(fontSize: 16.sp, color: Colors.black)), // Responsive font size
              onTap: () {
                Get.back();
                _showSettingsSheet();
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/settings/trash_icon.svg',
                  width: 24.w, height: 24.h), // Responsive SVG size
              trailing: Icon(Icons.keyboard_arrow_right_rounded,
                  size: 30.sp, color: AppColors.clrRed3), // Responsive icon size
              title: Text("Delete Leaderboard",
                  style: h4.copyWith(fontSize: 16.sp, color: AppColors.clrRed3)), // Responsive font size
              onTap: () {
                Get.back();
                _showDeleteSheet();
              },
            ),
            Padding(
              padding: EdgeInsets.all(30.w), // Responsive padding
              child: CustomButton(
                label: 'Rename',
                onPressed: () {
                  Get.back();
                  _showRenameLeaderboardSheet();
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
      isScrollControlled: true,
    );
  }

  void _showAddMember() {
    final TextEditingController _controller = TextEditingController();
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r), // Responsive border radius
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 24.sp), // Responsive icon size
                        onPressed: _showMoreOptionsBottomSheet,
                      ),
                      Text(
                        'Create Leaderboard',
                        style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/images/settings/cancel_icon.svg',
                        width: 24.w, height: 24.h), // Responsive SVG size
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Leaderboard name',
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
            ),
            Padding(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Create',
                  onPressed: () {
                    // Add rename logic here
                    Get.back();
                  },
                  color: AppColors.btnClr1,
                  txtClr: AppColors.btnTxt1,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
            ),
            SizedBox(height: 20.h), // Responsive spacing
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showRenameLeaderboardSheet() {
    final TextEditingController _controller = TextEditingController();
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r), // Responsive border radius
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 24.sp), // Responsive icon size
                        onPressed: _showMoreOptionsBottomSheet,
                      ),
                      Text(
                        'Rename Leaderboard',
                        style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/images/settings/cancel_icon.svg',
                        width: 24.w, height: 24.h), // Responsive SVG size
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Leaderboard name',
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
            ),
            Padding(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Submit',
                  onPressed: () {
                    // Add rename logic here
                    Get.back();
                  },
                  color: AppColors.btnClr1,
                  txtClr: AppColors.btnTxt1,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
            ),
            SizedBox(height: 20.h), // Responsive spacing
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showManageMembersSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r), // Responsive border radius
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 24.sp), // Responsive icon size
                        onPressed: _showMoreOptionsBottomSheet,
                      ),
                      Text(
                        'Manage members',
                        style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/images/settings/cancel_icon.svg',
                        width: 24.w, height: 24.h), // Responsive SVG size
                  ),
                ],
              ),
            ),
            Divider(),
            SwitchListTile(
              title: Text('Allow members to leave', style: h4.copyWith(fontSize: 16.sp)), // Responsive font size
              value: true, // Replace with actual state
              activeColor: Colors.white,
              inactiveThumbColor: AppColors.textBlue,
              inactiveTrackColor: AppColors.btnClr2,
              activeTrackColor: AppColors.textBlue,
              onChanged: (value) {
                // Add toggle logic
              },
            ),
            Padding(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: CustomButton(
                label: 'Reset',
                onPressed: () {
                  // Add reset logic
                  Get.back();
                },
                color: AppColors.btnClr1,
                txtClr: AppColors.btnTxt1,
                width: double.infinity, // Full-width button
                height: 50.h, // Responsive height
              ),
            ),
            SizedBox(height: 30.h), // Responsive spacing
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showSettingsSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r), // Responsive border radius
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 24.sp), // Responsive icon size
                        onPressed: _showMoreOptionsBottomSheet,
                      ),
                      Text(
                        'Settings',
                        style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/images/settings/cancel_icon.svg',
                        width: 24.w, height: 24.h), // Responsive SVG size
                  ),
                ],
              ),
            ),
            Divider(),
            SwitchListTile(
              title: Text('Group Steak', style: h4.copyWith(fontSize: 16.sp)), // Responsive font size
              value: true, // Replace with actual state
              activeColor: Colors.white,
              inactiveThumbColor: AppColors.textBlue,
              inactiveTrackColor: AppColors.btnClr2,
              activeTrackColor: AppColors.textBlue,
              onChanged: (value) {
                // Add toggle logic
              },
            ),
            SwitchListTile(
              title: Text('Auto remove inactive members', style: h4.copyWith(fontSize: 16.sp)), // Responsive font size
              value: false, // Replace with actual state
              activeColor: Colors.white,
              inactiveThumbColor: AppColors.textBlue,
              inactiveTrackColor: AppColors.btnClr2,
              activeTrackColor: AppColors.textBlue,
              onChanged: (value) {
                // Add toggle logic
              },
            ),
            Padding(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: CustomButton(
                label: 'Reset',
                onPressed: () {
                  // Add reset logic
                  Get.back();
                },
                color: AppColors.btnClr1,
                txtClr: AppColors.btnTxt1,
                width: double.infinity, // Full-width button
                height: 50.h, // Responsive height
              ),
            ),
            SizedBox(height: 30.h), // Responsive spacing
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showDeleteSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r), // Responsive border radius
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 24.sp), // Responsive icon size
                        onPressed: _showMoreOptionsBottomSheet,
                      ),
                      Text(
                        'Confirm',
                        style: h3.copyWith(fontSize: 18.sp, color: Colors.black), // Responsive font size
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/images/settings/cancel_icon.svg',
                        width: 24.w, height: 24.h), // Responsive SVG size
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h), // Responsive padding
                      decoration: BoxDecoration(
                        color: AppColors.clrRed5,
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                      ),
                      child: Text(
                        "Delete",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp, // Responsive font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w), // Responsive spacing
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h), // Responsive padding
                      decoration: BoxDecoration(
                        color: AppColors.btnClr2,
                        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                      ),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.btnTxt2,
                          fontSize: 14.sp, // Responsive font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h), // Responsive spacing
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showInviteFriendsSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w), // Responsive padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r), // Responsive border radius
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add friends here', style: h2.copyWith(fontSize: 16.sp)), // Responsive font size
            SizedBox(height: 20.h), // Responsive spacing
            CustomButton(
              label: 'Add',
              onPressed: () {
                // Add invite logic
                Get.back();
              },
              color: AppColors.btnClr1,
              txtClr: AppColors.btnTxt1,
              width: double.infinity, // Full-width button
              height: 50.h, // Responsive height
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildFrankfurtPlaceholder() {
    return Container(
      padding: EdgeInsets.all(20.w), // Responsive padding
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("5 DAYS LEFT", style: h4.copyWith(fontSize: 16.sp, color: AppColors.textBlue)), // Responsive font size
            SizedBox(height: 10.h), // Responsive spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weekly Leaderboard", style: h2.copyWith(fontSize: 24.sp, color: Colors.black)), // Responsive font size
                Material(
                  shape: const CircleBorder(),
                  color: AppColors.textBlue,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: _showAddMember,
                    child: Padding(
                      padding: EdgeInsets.all(3.w), // Responsive padding
                      child: Icon(Icons.add, color: Colors.white, size: 20.sp), // Responsive icon size
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}