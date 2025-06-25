import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quranapp/app/modules/authentication/views/authentication_view.dart';
import 'package:quranapp/app/modules/authentication/views/login_view.dart';
import 'package:quranapp/app/modules/home/views/home_view.dart';
import 'package:quranapp/app/modules/setup_profile/views/setup_profile_view.dart';

import '../views/forgot_password_view.dart';

class AuthenticationController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final currentStep = 0.obs;
  final email = ''.obs;
  final name = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.text = email.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Registration Step Navigation
  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 2) {
      currentStep.value = step;
    }
  }

  // Authentication Methods
  void signInWithApple() {
    print('Sign in with Apple');
    // TODO: Integrate Apple Sign-In
  }

  void signInWithGoogle() {
    print('Sign in with Google');
    // TODO: Integrate Google Sign-In
  }

  void goToLogin() {
    // TODO: Replace with actual navigation
    print('Navigate to Login');
    // Example: Get.toNamed('/login');
    Get.to(LoginView());
  }

  void goToSignup() {
    print('Navigate to Sign Up');
    // Get.toNamed('/signup'); or whatever your route is
    Get.to(AuthenticationView());
  }


  void goToForgotPassword() {
    // TODO: Replace with actual navigation
    print('Navigate to Forgot Password');
    Get.to(ForgotPasswordEmailView());
  }

  Future<void> completeRegistration() async {
    try {
      isLoading.value = true;
      //await Future.delayed(Duration(seconds: 2)); // Simulate API delay

      final userData = {
        'email': email.value,
        'name': name.value.isNotEmpty ? name.value : 'Nola L. Rushing',
        'username': username.value.isNotEmpty ? username.value : 'rushing11',
        'password': password.value,
      };

      print('Creating account with data: $userData');

      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // TODO: Navigate to dashboard or onboarding
      // Get.offAllNamed('/dashboard');

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create account. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    /*if (!isValidEmail(email.value) || !isValidPassword(password.value)) {
      Get.snackbar(
        'Invalid Input',
        'Please enter a valid email and password.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      //await Future.delayed(Duration(seconds: 2)); // Simulate API call

      final loginData = {
        'email': email.value,
        'password': password.value,
      };

      print('Logging in with: $loginData');

      Get.snackbar(
        'Welcome Back!',
        'Login successful.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // TODO: Navigate to dashboard
      // Get.offAllNamed('/dashboard');

    } catch (e) {
      Get.snackbar(
        'Login Failed',
        'Please check your credentials and try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }*/
    Get.snackbar(
      'Welcome Back!',
      'Login successful.',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.to(SetupProfileView());

  }

  // Validation Methods
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  bool isValidName(String name) {
    return name.isNotEmpty && name.length >= 2;
  }

  bool isValidUsername(String username) {
    return username.isNotEmpty && username.length >= 3;
  }

  // Field Updaters
  void updateEmail(String value) => email.value = value;
  void updateName(String value) => name.value = value;
  void updateUsername(String value) => username.value = value;
  void updatePassword(String value) => password.value = value;

  // Form Reset
  void resetForm() {
    currentStep.value = 0;
    email.value = '';
    name.value = '';
    username.value = '';
    password.value = '';
    emailController.clear();
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
  }
}
