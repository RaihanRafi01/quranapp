import 'package:flutter/material.dart';
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
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Learn Languages From the Content You Love',
                    style: h1.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    color: AppColors.btnClr1,
                    txtClr: AppColors.btnTxt1,
                    label: 'Get Started',
                    onPressed: () {
                      Get.to(AuthenticationView());
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    txtClr: AppColors.btnTxt2,
                    color: AppColors.btnClr2,
                    label: 'I already have an account',
                    onPressed: () {
                      Get.to(LoginView());
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}