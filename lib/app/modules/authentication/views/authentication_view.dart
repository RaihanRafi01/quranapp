import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});

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
            child: Obx(() {
              switch (controller.currentStep.value) {
                case 0:
                  return _buildStep1();
                case 1:
                  return _buildStep2();
                case 2:
                  return _buildStep3();
                default:
                  return _buildStep1();
              }
            }),
          ),
        ),
      ),
    );
  }

  // Step 1: Initial Email Input
  Widget _buildStep1() {
    return Padding(
      padding: EdgeInsets.all(24.w), // Responsive padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.h), // Responsive spacing
          Text(
            'Create Profile',
            style: h1, // Uses h1 with fontSize: 24.sp from customFont.dart
          ),
          SizedBox(height: 40.h), // Responsive spacing
          CustomTextField(
            hintText: 'Enter Email Address',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => controller.email.value = value,
          ),
          SizedBox(height: 24.h), // Responsive spacing
          Obx(() => CustomButton(
            label: 'Continue',
            onPressed: controller.email.value.isNotEmpty
                ? () => controller.nextStep()
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
          _buildSocialButtons(),
          SizedBox(height: 32.h), // Responsive spacing
          _buildLoginLink(),
          SizedBox(height: 16.h), // Responsive spacing
          _buildTermsText(),
        ],
      ),
    );
  }

  // Step 2: Email Confirmation
  Widget _buildStep2() {
    return Padding(
      padding: EdgeInsets.all(24.w), // Responsive padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.h), // Responsive spacing
          Text(
            'Create Profile',
            style: h1, // Uses h1 with fontSize: 24.sp
          ),
          SizedBox(height: 40.h), // Responsive spacing
          CustomTextField(
            hintText: 'Enter Email Address',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => controller.email.value = value,
          ),
          SizedBox(height: 24.h), // Responsive spacing
          Obx(() => CustomButton(
            label: 'Continue',
            onPressed: controller.email.value.isNotEmpty
                ? () => controller.nextStep()
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
          _buildSocialButtons(),
          SizedBox(height: 32.h), // Responsive spacing
          _buildLoginLink(),
          SizedBox(height: 16.h), // Responsive spacing
          _buildTermsText(),
        ],
      ),
    );
  }

  // Step 3: User Details (Final Step)
  Widget _buildStep3() {
    return Padding(
      padding: EdgeInsets.all(24.w), // Responsive padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.h), // Responsive spacing
          Text(
            'Create Profile',
            style: h1, // Uses h1 with fontSize: 24.sp
          ),
          SizedBox(height: 40.h), // Responsive spacing
          CustomTextField(
            hintText: 'Enter Email Address',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => controller.email.value = value,
            enabled: false, // Make email field read-only
          ),
          SizedBox(height: 16.h), // Responsive spacing
          CustomTextField(
            hintText: 'Name',
            controller: controller.nameController,
            onChanged: (value) => controller.name.value = value,
          ),
          SizedBox(height: 16.h), // Responsive spacing
          CustomTextField(
            hintText: 'User Name',
            controller: controller.usernameController,
            onChanged: (value) => controller.username.value = value,
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
            label: 'Get Started',
            onPressed: _canProceedStep3()
                ? () => controller.completeRegistration()
                : () {},
            color: _canProceedStep3() ? AppColors.btnClr1 : AppColors.btnClr2,
            txtClr: AppColors.btnTxt1,
            width: double.infinity, // Full-width button
            height: 50.h, // Responsive height
          )),
          SizedBox(height: 32.h), // Responsive spacing
          _buildLoginLink(),
          SizedBox(height: 16.h), // Responsive spacing
          _buildTermsText(),
        ],
      ),
    );
  }

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

  Widget _buildLoginLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already signed up? ',
            style: h2.copyWith(fontSize: 16.sp, color: AppColors.textColor), // Responsive font size
          ),
          GestureDetector(
            onTap: () => controller.goToLogin(),
            child: Text(
              'Log In',
              style: h2.copyWith(
                fontSize: 16.sp, // Responsive font size
                color: AppColors.textBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w), // Responsive padding
      child: Center(
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
      ),
    );
  }

  bool _canProceedStep3() {
    return controller.name.value.isNotEmpty &&
        controller.username.value.isNotEmpty &&
        controller.password.value.isNotEmpty;
  }
}