import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/common/widgets/customButton.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
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
          // Conditionally show top leaderboard or Frankfurt placeholder
          Obx(() {
            final isFrankfurt = controller.selectedTab.value == 'Frankfurt';
            final isJamal = controller.selectedTab.value == 'Jamal';
            if (isFrankfurt || isJamal) {
              return _buildFrankfurtPlaceholder();
            } else {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: controller.leaderboard.length < 3
                    ? const SizedBox.shrink()
                    : Column(
                  children: [
                    SafeArea(
                      child: Text(
                        'Leaderboard',
                        style: h2.copyWith(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 200,
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
                              height: 80,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: _buildTopUser(
                              rank: 1,
                              name: controller.leaderboard[0].name,
                              points: '${controller.leaderboard[0].points} pts',
                              avatar: controller.leaderboard[0].avatar,
                              height: 100,
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
                              height: 90,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
          }),

          // Location tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

          // Rankings list or fallback message
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
                  padding: const EdgeInsets.all(16),
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
          height: 100,
          width: 80,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.clrGreen,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: AssetImage(avatar),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
              ),
              Positioned(
                bottom: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.clrGreen,
                  child: Text(
                    '$rank',
                    style: h1.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: h2.copyWith(fontSize: 13),
        ),
        Text(
          points,
          style: h4.copyWith(fontSize: 13),
        ),
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
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.blueDeep : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 50,
            color: isSelected ? AppColors.blueDeep : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(int rank, String name, String points, String avatar, {bool isCurrentUser = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.clrGreen : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            rank.toString().padLeft(2, '0'),
            style: h1.copyWith(fontSize: 14),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(avatar),
            onBackgroundImageError: (_, __) {},
            child: const Icon(Icons.person, color: Colors.grey, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: h2.copyWith(fontSize: 14),
            ),
          ),
          Text(
            points,
            style: h3.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildNotEnoughUsersMessage() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/home/map_icon.svg'),
                  const SizedBox(width: 10),
                  Text('Frankfurt', style: h4.copyWith(fontSize: 16)),
                ],
              ),
              Text('Edit', style: h4.copyWith(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            "Frankfurt doesn’t have enough Kalaam users yet.",
            style: h2.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Only 7 more users needed to unlock “Frankfurt” leaderboard. Winners get exclusive badges for their profile. Invite your friends to join and be part of this rewarding experience!",
            style: h4.copyWith(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            label: 'Invite Friends',
            onPressed: () {},
            color: AppColors.btnClr1,
            txtClr: AppColors.btnTxt1,
          ),
        ],
      ),
    );
  }


  Widget _buildUser() {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You haven't added any friends yet",
            style: h2.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Add some of your real-life friends and family to start competing!",
            style: h4.copyWith(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.btnClr1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Add Friends",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/images/settings/user_add_icon.svg', // update path as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.blue),
                onPressed: () {
                  _showMoreOptionsBottomSheet();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showMoreOptionsBottomSheet() {
    Get.bottomSheet(
      Container(
        //padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Close Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 10,),
                      Text(
                        "More Options",
                        style: h3.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      'assets/images/settings/cancel_icon.svg',
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            const SizedBox(height: 20),
            // Invite friends option
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/settings/mail_icon.svg',
              ),
              trailing: Icon(Icons.keyboard_arrow_right_rounded,size: 30,color: AppColors.arrowClr,),
              title: Text(
                "Rename Leaderboard",
                style: h4.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back(); // Close bottom sheet
                // Add your invite friends logic here
              },
            ),
            // Manage members option
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/settings/messages_icon.svg',
              ),
              trailing: Icon(Icons.keyboard_arrow_right_rounded,size: 30,color: AppColors.arrowClr,),
              title: Text(
                "Manage members",
                style: h4.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back(); // Close bottom sheet
                // Add your manage members logic here
              },
            ),
            // Settings option
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/settings/settings_icon.svg',

              ),
              trailing: Icon(Icons.keyboard_arrow_right_rounded,size: 30,color: AppColors.arrowClr,),
              title: Text(
                "Settings",
                style: h4.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Get.back(); // Close bottom sheet
                // Add your settings logic here
              },
            ),
            // Leave group option
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/settings/trash_icon.svg',
              ),
              trailing: Icon(Icons.keyboard_arrow_right_rounded,size: 30,color: AppColors.clrRed3,),
              title: Text(
                "Delete Leaderboard",
                style: h4.copyWith(
                  fontSize: 16,
                  color: AppColors.clrRed3,
                ),
              ),
              onTap: () {
                Get.back(); // Close bottom sheet
                _showLeaveGroupConfirmation();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: CustomButton(label: 'Rename', onPressed: (){}, color: AppColors.btnClr1, txtClr: AppColors.btnTxt1),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
  void _showLeaveGroupConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Leave Group",
          style: h2.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          "Are you sure you want to leave this group?",
          style: h4.copyWith(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: h4.copyWith(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // Add your leave group logic here
            },
            child: Text(
              "Leave",
              style: h4.copyWith(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildFrankfurtPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "5 DAYS LEFT",
              style: h4.copyWith(
                fontSize: 16,
                color: AppColors.textBlue,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Weekly Leaderboard",
                  style: h2.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                Material(
                  shape: const CircleBorder(),
                  color: AppColors.textBlue,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      // Your action here
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(Icons.add, color: Colors.white, size: 20),
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