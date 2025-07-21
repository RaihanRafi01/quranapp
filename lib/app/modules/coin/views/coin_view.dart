import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/coin_controller.dart';

class CoinView extends GetView<CoinController> {
  const CoinView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final CoinController coinController = Get.put(CoinController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textBlue, size: 24.sp),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Quranic Stats', style: h2.copyWith(fontSize: 17.sp)),
            SizedBox(height: 20.h),
            // Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/home/coin_big.png', scale: 4.w),
                  SizedBox(height: 16.h),
                  Obx(() => Text(
                    '${coinController.isToday.value ? coinController.todayCoins : coinController.allTimeCoins}/50 Coins',
                    style: h1.copyWith(fontSize: 18.sp),
                  )),
                  SizedBox(height: 4.h),
                  Text(
                    'Keep working towards your daily goal!',
                    style: h4.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/home/coin_icon.png', scale: 4.w),
                  Text('Coin Balance', style: h4.copyWith(fontSize: 16.sp)),
                  Obx(() => Text(
                    '${coinController.isToday.value ? coinController.todayCoins : coinController.allTimeCoins}',
                    style: h1.copyWith(fontSize: 20.sp),
                  )),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // 7 Day Activity Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('7 Day Activity', style: h1.copyWith(fontSize: 20.sp)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          'Quranic Mastery Method:',
                          style: h4.copyWith(fontSize: 14.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.keyboard_arrow_right_outlined, size: 24.sp),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Obx(() => _buildActivityItem(
                    'Learned lesson:',
                    coinController.isToday.value
                        ? coinController.todayLessons.toString()
                        : coinController.allTimeLessons.toString(),
                    2,
                  )),
                  Divider(height: 24.h),
                  Obx(() => _buildActivityItem(
                    'Hours Listened:',
                    coinController.isToday.value
                        ? coinController.todayHoursListened.toString()
                        : coinController.allTimeHoursListened.toString(),
                    1,
                  )),
                  Divider(height: 24.h),
                  Obx(() => _buildActivityItem(
                    'Marked as learned:',
                    coinController.isToday.value
                        ? coinController.todayMarkedLearned.toString()
                        : coinController.allTimeMarkedLearned.toString(),
                    1,
                  )),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // 14 Days Streak Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('14 Days Streak', style: h1.copyWith(fontSize: 20.sp)),
                Row(
                  children: [
                    Text('Calendar', style: h4.copyWith(fontSize: 14.sp)),
                    SizedBox(width: 10.w),
                    Icon(Icons.keyboard_arrow_right_outlined, size: 24.sp),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/images/home/fire_inactive.svg', width: 24.w, height: 24.h),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg', width: 24.w, height: 24.h),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg', width: 24.w, height: 24.h),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg', width: 24.w, height: 24.h),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg', width: 24.w, height: 24.h),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg', width: 24.w, height: 24.h),
                      SvgPicture.asset('assets/images/home/fire_inactive.svg', width: 24.w, height: 24.h),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tue', style: h4.copyWith(fontSize: 14.sp)),
                      Text('Wed', style: h4.copyWith(fontSize: 14.sp)),
                      Text('Thu', style: h4.copyWith(fontSize: 14.sp)),
                      Text('Fri', style: h4.copyWith(fontSize: 14.sp)),
                      Text('Sat', style: h4.copyWith(fontSize: 14.sp)),
                      Text('Sun', style: h4.copyWith(fontSize: 14.sp)),
                      Text('Mon', style: h4.copyWith(fontSize: 14.sp)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stats', style: h1.copyWith(fontSize: 20.sp)),
                Text('View All', style: h4.copyWith(fontSize: 14.sp)),
              ],
            ),
            SizedBox(height: 12.h),
            // Toggle buttons for Today/All Time
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          coinController.setToday(true);
                        },
                        child: Obx(() => Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: coinController.isToday.value ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: coinController.isToday.value
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4.r,
                                offset: Offset(0, 1.h),
                              ),
                            ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              'Today',
                              style: h1.copyWith(
                                fontSize: 16.sp,
                                color: coinController.isToday.value ? Colors.black : Colors.grey[600],
                              ),
                            ),
                          ),
                        )),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          coinController.setToday(false);
                        },
                        child: Obx(() => Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: !coinController.isToday.value ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: !coinController.isToday.value
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4.r,
                                offset: Offset(0, 1.h),
                              ),
                            ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              'All Time',
                              style: h4.copyWith(
                                fontSize: 16.sp,
                                color: !coinController.isToday.value ? Colors.black : Colors.grey[600],
                              ),
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Stats Grid
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // First Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Coins', style: h3.copyWith(fontSize: 14.sp)),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Image.asset('assets/images/home/coin_icon.png', scale: 6.w),
                                SizedBox(width: 8.w),
                                Obx(() => Text(
                                  coinController.isToday.value
                                      ? coinController.todayCoins.toString()
                                      : coinController.allTimeCoins.toString(),
                                  style: h1.copyWith(fontSize: 18.sp),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1.w, height: 60.h, color: Colors.grey[200]),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Known Words', style: h3.copyWith(fontSize: 14.sp)),
                              SizedBox(height: 8.h),
                              Obx(() => Text(
                                coinController.isToday.value
                                    ? coinController.todayKnownWords.toString()
                                    : coinController.allTimeKnownWords.toString(),
                                style: h1.copyWith(fontSize: 18.sp),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(height: 1.h, color: Colors.grey[200]),
                  SizedBox(height: 16.h),
                  // Second Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Study Time', style: h3.copyWith(fontSize: 14.sp)),
                            SizedBox(height: 8.h),
                            Obx(() => Text(
                              coinController.isToday.value
                                  ? coinController.todayStudyTime.value
                                  : coinController.allTimeStudyTime.value,
                              style: h1.copyWith(fontSize: 18.sp),
                            )),
                          ],
                        ),
                      ),
                      Container(width: 1.w, height: 60.h, color: Colors.grey[200]),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hours listened', style: h3.copyWith(fontSize: 14.sp)),
                              SizedBox(height: 8.h),
                              Obx(() => Text(
                                coinController.isToday.value
                                    ? '${coinController.todayHoursListened} +'
                                    : '${coinController.allTimeHoursListened} +',
                                style: h1.copyWith(fontSize: 18.sp),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Achievements Section
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Level', style: h1.copyWith(fontSize: 20.sp)),
              ],
            ),
            SizedBox(height: 12.h),
            Column(
              children: [
                _buildAchievementItem(
                  'assets/images/home/a1.png',
                  '1000 learned words',
                  '30% of the Quran',
                ),
                SizedBox(height: 12.h),
                _buildAchievementItem(
                  'assets/images/home/a2.png',
                  '2000 learned words',
                  '50% of the Quran',
                ),
                SizedBox(height: 12.h),
                _buildAchievementItem(
                  'assets/images/home/b1.png',
                  '4000 learned words',
                  '70% of the Quran',
                ),
                SizedBox(height: 12.h),
                _buildAchievementItem(
                  'assets/images/home/b2.png',
                  '4000 learned words',
                  '90% of the Quran',
                ),
                SizedBox(height: 12.h),
                _buildAchievementItem(
                  'assets/images/home/c1.png',
                  '6500 learned words',
                  '100% of the Quran',
                ),
                SizedBox(height: 12.h),
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
            Text(title, style: h4.copyWith(fontSize: 16.sp)),
            SizedBox(width: 10.w),
            Text(count, style: h1.copyWith(fontSize: 16.sp)),
          ],
        ),
        Row(
          children: [
            Text('Attention', style: h1.copyWith(fontSize: 16.sp, color: AppColors.textBlue)),
            SizedBox(width: 4.w),
            Icon(Icons.keyboard_arrow_right_outlined, size: 24.sp),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementItem(String path, String title, String subtitle) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: h4.copyWith(fontSize: 20.sp)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Image.asset(path, scale: 4.w),
          ),
          Text(subtitle, style: h4.copyWith(fontSize: 20.sp)),
        ],
      ),
    );
  }
}