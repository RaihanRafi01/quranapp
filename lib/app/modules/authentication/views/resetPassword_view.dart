import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                'Create a new password',
                style: h1.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              CustomTextField(
                hintText: 'New password',
                isPassword: true,
                onChanged: (value) => controller.password.value = value,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Confirm password',
                isPassword: true,
                onChanged: (value) => controller.username.value = value, // Adjust if needed
              ),
              SizedBox(height: 24),
              Obx(() => CustomButton(
                label: 'Continue',
                onPressed: controller.password.value.length >= 6
                    ? () {
                  // TODO: Implement reset password logic
                  Get.snackbar("Success", "Password reset successfully!");
                  Get.offAll(LoginView());
                }
                    : () {},
                color: controller.password.value.length >= 6
                    ? AppColors.btnClr1
                    : AppColors.btnClr2,
                txtClr: AppColors.btnTxt1,
              )),
              SizedBox(height: 24),
              _buildTermsText(),
              SizedBox(height: 16),
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
          style: h4.copyWith(fontSize: 12, color: Colors.grey[600]),
          children: [
            TextSpan(text: 'By using Quranic Mastery you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}
