import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/authentication/views/authentication_view.dart';
import 'package:quranapp/app/modules/authentication/views/login_view.dart';
import 'package:quranapp/common/widgets/customButton.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Image.asset(
                'assets/images/onboarding/onboarding_image.png',
                fit: BoxFit.contain,
                width: 300.w, // Responsive width
                height: 300.h, // Responsive height
              ),
            ),
            SizedBox(height: 50.h), // Responsive spacing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
              child: Column(
                children: [
                  Text(
                    'Learn Languages From the Content You Love',
                    style: h1, // Use h1 directly, as it has fontSize: 24.sp
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50.h), // Responsive spacing
                  CustomButton(
                    color: AppColors.btnClr1,
                    txtClr: AppColors.btnTxt1,
                    label: 'Get Started',
                    width: double.infinity, // Full-width button
                    height: 50.h, // Responsive height
                    onPressed: () {
                      Get.to(const AuthenticationView());
                    },
                  ),
                  SizedBox(height: 16.h), // Responsive spacing
                  CustomButton(
                    txtClr: AppColors.btnTxt2,
                    color: AppColors.btnClr2,
                    label: 'I already have an account',
                    width: double.infinity, // Full-width button
                    height: 50.h, // Responsive height
                    onPressed: () {
                      Get.to(const LoginView());
                    },
                  ),
                  SizedBox(height: 24.h), // Responsive spacing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}