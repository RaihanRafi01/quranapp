import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/coin_controller.dart';

class CoinView extends GetView<CoinController> {
  const CoinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textBlue),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Quranic  Stats',style: h2.copyWith(fontSize: 17),),
            SizedBox(height: 20),
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/home/coin_big.png',scale: 4,),
                  const SizedBox(height: 16),
                  Text(
                    '0/50 Coins',
                    style: h1.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Keep working towards your daily goal!',
                    style: h4.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/home/coin_icon.png',scale: 4,),
                  Text('Coin Balance',style: h4.copyWith(fontSize: 16)),
                  Text('20',style: h1.copyWith(fontSize: 20)),
                ],
              )
            ),

            const SizedBox(height: 24),

            // 7 Day Activity Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '7 Day Activity',
                  style: h1.copyWith(
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Quranic Mastery Method:',
                      style: h4.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.keyboard_arrow_right_outlined)
                  ],
                ),

              ],
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildActivityItem('Learned lesson:', '1', 2),
                  const Divider(height: 24),
                  _buildActivityItem('Hours Listened:', '0', 1),
                  const Divider(height: 24),
                  _buildActivityItem('Marked as learned:', '1', 1),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 14 Days Streak Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '14 Days Streak',
                  style: h1.copyWith(
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Calendar',
                      style: h4.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.keyboard_arrow_right_outlined)
                  ],
                ),

              ],
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/images/home/fire_inactive.svg'),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg'),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg'),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg'),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg'),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg'),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tue',
                        style: h4.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Wed',
                        style: h4.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Thu',
                        style: h4.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Fri',
                        style: h4.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Sat',
                        style: h4.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Sun',
                        style: h4.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Mon',
                        style: h4.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stats',
                  style: h1.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'View All',
                  style: h4.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // design here !

            // Achievements Section
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Achievements',
                  style: h1.copyWith(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Column(
              children: [
                _buildAchievementItem(
                  'assets/images/home/a1.png',
                  '1000 learned words',
                  '30% of the Quran',
                ),
                const SizedBox(height: 12),
                _buildAchievementItem(
                  'assets/images/home/a1.png',
                  '2000 learned words',
                  '50% of the Quran',
                ),
                const SizedBox(height: 12),
                _buildAchievementItem(
                  'assets/images/home/b1.png',
                  '4000 learned words',
                  '70% of the Quran',
                ),
                const SizedBox(height: 12),
                _buildAchievementItem(
                  'assets/images/home/b2.png',
                  '4000 learned words',
                  '90% of the Quran',
                ),
                const SizedBox(height: 12),
                _buildAchievementItem(
                  'assets/images/home/c1.png',
                  '6500 learned words',
                  '100% of the Quran',
                ),
                const SizedBox(height: 12),
                _buildAchievementItem(
                  'assets/images/home/c2.png',
                  '9500 learned words',
                  '100% of the Quran, Hadiths, Tafsir, Films, and scholar lectures',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String count, int coins) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: h4.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(width: 10,),
            Text(
              count,
              style: h1.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Attention',
              style: h1.copyWith(
                fontSize: 16,
                color: AppColors.textBlue
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_right_outlined)
          ],
        ),
      ],
    );
  }

  Widget _buildStreakDay(String day, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? Colors.orange : Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementItem(
      String path,
      String title,
      String subtitle,
      ) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title,style: h4.copyWith(fontSize: 20)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.asset(path,scale: 4,),
          ),
          Text(subtitle,style: h4.copyWith(fontSize: 20)),
        ],
      ),
    );
  }
}