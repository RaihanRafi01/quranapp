import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/authentication/views/login_view.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';
import '../controllers/authentication_controller.dart';

class ResetPasswordView extends StatelessWidget {
  final controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h), // Responsive spacing
              Text(
                'Create a new password',
                style: h1, // Uses h1 with fontSize: 24.sp
              ),
              SizedBox(height: 40.h), // Responsive spacing
              CustomTextField(
                hintText: 'New password',
                isPassword: true,
                onChanged: (value) => controller.password.value = value,
              ),
              SizedBox(height: 16.h), // Responsive spacing
              CustomTextField(
                hintText: 'Confirm password',
                isPassword: true,
                onChanged: (value) => controller.username.value = value, // Adjust if needed
              ),
              SizedBox(height: 24.h), // Responsive spacing
              Obx(() => CustomButton(
                label: 'Continue',
                onPressed: controller.password.value.length >= 6
                    ? () {
                  // TODO: Implement reset password logic
                  Get.snackbar("Success", "Password reset successfully!");
                  Get.offAll(() => const LoginView());
                }
                    : () {},
                color: controller.password.value.length >= 6
                    ? AppColors.btnClr1
                    : AppColors.btnClr2,
                txtClr: AppColors.btnTxt1,
                width: double.infinity, // Full-width button
                height: 50.h, // Responsive height
              )),
              SizedBox(height: 24.h), // Responsive spacing
              _buildTermsText(),
              SizedBox(height: 16.h), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: h4.copyWith(fontSize: 12.sp, color: Colors.grey[600]), // Responsive font size
          children: [
            const TextSpan(text: 'By using Quranic Mastery you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12.sp, // Responsive font size
                decoration: TextDecoration.underline,
              ),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12.sp, // Responsive font size
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}