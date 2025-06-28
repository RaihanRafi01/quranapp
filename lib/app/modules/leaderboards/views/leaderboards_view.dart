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
          // Top 3 users section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              if (controller.leaderboard.length < 3) return const SizedBox.shrink();
              return Column(
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
              );
            }),
          ),

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
              ],
            )),
          ),

          // Rankings list or fallback message
          Expanded(
            child: Obx(() {
              final isFrankfurt = controller.selectedTab.value == 'Frankfurt';
              final hasEnoughUsers = controller.leaderboard.length > 3;

              if (isFrankfurt) {
                return _buildNotEnoughUsersMessage();
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
              // Avatar with border
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

              // Rank badge
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
              color: isSelected ? Colors.green : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 50,
            color: isSelected ? Colors.green : Colors.transparent,
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
      // /margin: const EdgeInsets.all(16),
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
                  SizedBox(width: 10),
                  Text('Frankfurt',style: h4.copyWith(fontSize: 16),)
                ],
              ),
              Text('Edit',style: h4.copyWith(fontSize: 16),)
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
          CustomButton(label: 'Invite Friends', onPressed: (){}, color: AppColors.btnClr1, txtClr: AppColors.btnTxt1)
        ],
      ),
    );
  }
}
