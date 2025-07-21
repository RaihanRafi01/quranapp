import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';
import '../controllers/authentication_controller.dart';

class LoginView extends GetView<AuthenticationController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthenticationController());
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 60.h, // Responsive height
            ),
            child: _buildLoginForm(),
          ),
        ),
      ),
    );
  }

  // Login Form
  Widget _buildLoginForm() {
    return Padding(
      padding: EdgeInsets.all(24.w), // Responsive padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.h), // Responsive spacing
          Text(
            'Log In',
            style: h1, // Uses h1 with fontSize: 24.sp
          ),
          SizedBox(height: 40.h), // Responsive spacing
          CustomTextField(
            hintText: 'Enter Email Address',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => controller.email.value = value,
          ),
          SizedBox(height: 16.h), // Responsive spacing
          CustomTextField(
            hintText: 'Password',
            controller: controller.passwordController,
            isPassword: true,
            onChanged: (value) => controller.password.value = value,
          ),
          SizedBox(height: 24.h), // Responsive spacing
          Obx(() => CustomButton(
            label: 'Log In',
            onPressed: controller.email.value.isNotEmpty && controller.password.value.isNotEmpty
                ? () => controller.login()
                : () {},
            color: controller.email.value.isNotEmpty && controller.password.value.isNotEmpty
                ? AppColors.btnClr1
                : AppColors.btnClr2,
            txtClr: AppColors.btnTxt1,
            width: double.infinity, // Full-width button
            height: 50.h, // Responsive height
          )),
          SizedBox(height: 32.h), // Responsive spacing
          _buildForgotPasswordLink(),
          SizedBox(height: 32.h), // Responsive spacing
          _buildDivider(),
          SizedBox(height: 24.h), // Responsive spacing
          _buildSocialButtons(),
          SizedBox(height: 16.h), // Responsive spacing
          _buildSignUpLink(),
          SizedBox(height: 16.h),
          _buildTermsText(),
        ],
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: h2.copyWith(fontSize: 16.sp, color: AppColors.textColor), // Responsive font size
          ),
          GestureDetector(
            onTap: () => controller.goToSignup(),
            child: Text(
              'Sign Up',
              style: h2.copyWith(fontSize: 16.sp, color: AppColors.textBlue), // Responsive font size
            ),
          ),
        ],
      ),
    );
  }

  // Forgot Password Link
  Widget _buildForgotPasswordLink() {
    return Center(
      child: GestureDetector(
        onTap: () => controller.goToForgotPassword(),
        child: Text(
          'Forgot Password?',
          style: h2.copyWith(fontSize: 16.sp, color: AppColors.textBlue), // Responsive font size
        ),
      ),
    );
  }

  // Divider with Social Buttons
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
          child: Text(
            'Or',
            style: h4.copyWith(fontSize: 14.sp, color: Colors.grey[600]), // Responsive font size
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  // Social Media Sign-In Buttons
  Widget _buildSocialButtons() {
    return Column(
      children: [
        _buildSocialButton(
          onPressed: () => controller.signInWithApple(),
          assetPath: 'assets/images/auth/apple_icon.svg',
          label: 'Continue with Apple',
        ),
        SizedBox(height: 12.h), // Responsive spacing
        _buildSocialButton(
          onPressed: () => controller.signInWithGoogle(),
          assetPath: 'assets/images/auth/google_icon.svg',
          label: 'Continue with Google',
        ),
      ],
    );
  }

  // Social Button Component
  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String assetPath,
    required String label,
  }) {
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r), // Responsive border radius
          ),
          padding: EdgeInsets.zero,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                label,
                style: h3.copyWith(fontSize: 16.sp, color: AppColors.textColor), // Responsive font size
              ),
            ),
            Positioned(
              left: 16.w, // Responsive positioning
              child: SvgPicture.asset(
                assetPath,
                height: 20.h, // Responsive height
                width: 20.w, // Responsive width
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Terms Text at the Bottom
  Widget _buildTermsText() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w), // Responsive padding
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: h4.copyWith(fontSize: 12.sp, color: Colors.grey[600]), // Responsive font size
            children: [
              const TextSpan(text: 'By logging in, you agree to our '),
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
      ),
    );
  }
}