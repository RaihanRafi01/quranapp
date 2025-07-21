import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              padding: EdgeInsets.all(24.w), // Responsive padding
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      60.h, // Responsive height for terms
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h), // Responsive spacing
                    Text(
                      'Forgot password',
                      style: h1,// Uses h1 with fontSize: 24.sp
                    ),
                    SizedBox(height: 40.h), // Responsive spacing
                    CustomTextField(
                      hintText: 'Enter your email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => controller.email.value = value,
                    ),
                    SizedBox(height: 24.h), // Responsive spacing
                    Obx(() => CustomButton(
                      label: 'Continue',
                      onPressed: controller.email.value.isNotEmpty
                          ? () => Get.to(() => ResetPasswordView())
                          : () {},
                      color: controller.email.value.isNotEmpty
                          ? AppColors.btnClr1
                          : AppColors.btnClr2,
                      txtClr: AppColors.btnTxt1,
                      width: double.infinity, // Full-width button
                      height: 50.h, // Responsive height
                    )),
                    SizedBox(height: 32.h), // Responsive spacing
                    _buildDivider(),
                    SizedBox(height: 24.h), // Responsive spacing
                    _buildSocialButtons(controller),
                    SizedBox(height: 16.h), // Responsive spacing
                    _buildSignUpLink(controller),
                    SizedBox(height: 100.h), // Responsive spacing for terms
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
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h), // Responsive padding
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
          padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
          child: Text('Or', style: h4.copyWith(fontSize: 14.sp, color: Colors.grey[600])), // Responsive font size
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildSocialButtons(AuthenticationController controller) {
    return Column(
      children: [
        _buildSocialButton(controller.signInWithApple, 'assets/images/auth/apple_icon.svg', 'Continue with Apple'),
        SizedBox(height: 12.h), // Responsive spacing
        _buildSocialButton(controller.signInWithGoogle, 'assets/images/auth/google_icon.svg', 'Continue with Google'),
      ],
    );
  }

  Widget _buildSocialButton(VoidCallback onPressed, String assetPath, String label) {
    return Container(
      height: 50.h, // Responsive height
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textColor),
        borderRadius: BorderRadius.circular(8.r), // Responsive border radius
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)), // Responsive border radius
          padding: EdgeInsets.zero,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(child: Text(label, style: h3.copyWith(fontSize: 16.sp, color: AppColors.textColor))), // Responsive font size
            Positioned(
              left: 16.w, // Responsive positioning
              child: SvgPicture.asset(assetPath, height: 20.h, width: 20.w), // Responsive SVG size
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
          Text("Already signed up? ", style: h2.copyWith(fontSize: 16.sp, color: AppColors.textColor)), // Responsive font size
          GestureDetector(
            onTap: () => controller.goToLogin(),
            child: Text('Log In', style: h2.copyWith(fontSize: 16.sp, color: AppColors.textBlue)), // Responsive font size
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
          style: h4.copyWith(fontSize: 12.sp, color: Colors.grey[600]), // Responsive font size
          children: [
            const TextSpan(text: 'By using Quranic Mastery you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(color: Colors.blue, fontSize: 12.sp, decoration: TextDecoration.underline), // Responsive font size
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(color: Colors.blue, fontSize: 12.sp, decoration: TextDecoration.underline), // Responsive font size
            ),
          ],
        ),
      ),
    );
  }
}