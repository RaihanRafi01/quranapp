import 'package:flutter/material.dart';
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
        child: Stack(
          children: [
            // Scrollable main content
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 60, // Adjust for terms text height
                ),
                child: _buildLoginForm(),
              ),
            ),
            // Terms text at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildTermsText(),
            ),
          ],
        ),
      ),
    );
  }

  // Login Form
  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Text(
            'Log In',
            style: h1.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 40),
          CustomTextField(
            hintText: 'Enter Email Address',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => controller.email.value = value,
          ),
          SizedBox(height: 16),
          CustomTextField(
            hintText: 'Password',
            controller: controller.passwordController,
            isPassword: true,
            onChanged: (value) => controller.password.value = value,
          ),
          SizedBox(height: 24),
          Obx(() => CustomButton(
            label: 'Log In',
            onPressed: controller.email.value.isNotEmpty && controller.password.value.isNotEmpty
                ? () => controller.login()
                : () {},
            color: controller.email.value.isNotEmpty && controller.password.value.isNotEmpty
                ? AppColors.btnClr1
                : AppColors.btnClr2,
            txtClr: AppColors.btnTxt1,
          )),
          SizedBox(height: 32),
          _buildForgotPasswordLink(),
          SizedBox(height: 32),
          _buildDivider(),
          SizedBox(height: 24),
          _buildSocialButtons(),
          SizedBox(height: 16),
          _buildSignUpLink(),
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
            style: h2.copyWith(fontSize: 16, color: AppColors.textColor),
          ),
          GestureDetector(
            onTap: () => controller.goToSignup(), // Make sure this method exists
            child: Text(
              'Sign Up',
              style: h2.copyWith(fontSize: 16, color: AppColors.textBlue),
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
          style: h2.copyWith(
            fontSize: 16,
            color: AppColors.textBlue,
          ),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or',
            style: h4.copyWith(fontSize: 14, color: Colors.grey[600]),
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
        SizedBox(height: 12),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                label,
                style: h3.copyWith(fontSize: 16, color: AppColors.textColor),
              ),
            ),
            Positioned(
              left: 16,
              child: SvgPicture.asset(
                assetPath,
                height: 20,
                width: 20,
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
      padding: EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: h4.copyWith(fontSize: 12, color: Colors.grey[600]),
            children: [
              TextSpan(text: 'By logging in, you agree to our '),
              TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  color: Colors.blue,
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
