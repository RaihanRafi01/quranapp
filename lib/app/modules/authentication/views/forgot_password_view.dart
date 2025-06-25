import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';
import '../controllers/authentication_controller.dart';
import 'resetPassword_view.dart';

class ForgotPasswordEmailView extends StatelessWidget {
  final controller = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      60, // Reserve space for terms
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Text(
                      'Forgot password',
                      style: h1.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      hintText: 'Enter your email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => controller.email.value = value,
                    ),
                    SizedBox(height: 24),
                    Obx(() => CustomButton(
                      label: 'Continue',
                      onPressed: controller.email.value.isNotEmpty
                          ? () => Get.to(() => ResetPasswordView())
                          : () {},
                      color: controller.email.value.isNotEmpty
                          ? AppColors.btnClr1
                          : AppColors.btnClr2,
                      txtClr: AppColors.btnTxt1,
                    )),
                    SizedBox(height: 32),
                    _buildDivider(),
                    SizedBox(height: 24),
                    _buildSocialButtons(controller),
                    SizedBox(height: 16),
                    _buildSignUpLink(controller),
                    SizedBox(height: 100), // Provide space so content scrolls above the terms
                  ],
                ),
              ),
            ),
            // Fixed Terms at Bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: _buildTermsText(),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Or', style: h4.copyWith(fontSize: 14, color: Colors.grey[600])),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildSocialButtons(AuthenticationController controller) {
    return Column(
      children: [
        _buildSocialButton(controller.signInWithApple, 'assets/images/auth/apple_icon.svg', 'Continue with Apple'),
        SizedBox(height: 12),
        _buildSocialButton(controller.signInWithGoogle, 'assets/images/auth/google_icon.svg', 'Continue with Google'),
      ],
    );
  }

  Widget _buildSocialButton(VoidCallback onPressed, String assetPath, String label) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(child: Text(label, style: h3.copyWith(fontSize: 16, color: AppColors.textColor))),
            Positioned(
              left: 16,
              child: SvgPicture.asset(assetPath, height: 20, width: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpLink(AuthenticationController controller) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already signed up? ", style: h2.copyWith(fontSize: 16, color: AppColors.textColor)),
          GestureDetector(
            onTap: () => controller.goToLogin(),
            child: Text('Log In', style: h2.copyWith(fontSize: 16, color: AppColors.textBlue)),
          ),
        ],
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
