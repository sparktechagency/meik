import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/core/app_constants/app_constants.dart';
import 'package:danceattix/core/config/app_route.dart';
import 'package:danceattix/helper/prefs_helper.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  /// <======================= register ===========================>
  bool isLoadingRegister = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void cleanFieldRegister() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPassController.clear();
    locationController.clear();
  }

  Future<void> register() async {
    isLoadingRegister = true;
    update();

    try {
      final requestBody = {
        "firstName": firstNameController.text.trim(),
        "lastName": firstNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": confirmPassController.text,
        "phone": phoneController.text.trim(),
        "address": locationController.text.trim(),
        "currency": "GBP"
      };

      final response = await ApiClient.postData(
        ApiUrls.register,
        requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      final responseBody = response.body;

      if (response.statusCode == 201) {
        await PrefsHelper.setString(AppConstants.bearerToken, responseBody['token'] ?? '');
        await PrefsHelper.setString(AppConstants.userId, responseBody['user']?['id'] ?? '');
        Get.toNamed(AppRoutes.otpScreen, arguments: 'registration');
        cleanFieldRegister();
      } else {
        showToast(responseBody['message']);
      }
    } catch (e) {
      showToast('Something went wrong. Please try again.');
      if (kDebugMode) print('Register error: $e');
    } finally {
      isLoadingRegister = false;
      update();
    }
  }

  /// <======================= verifyOTP ===========================>
  bool isLoadingOtp = false;
  final TextEditingController otpController = TextEditingController();

  Future<bool> verifyOTP({required String verificationType}) async {
    isLoadingOtp = true;
    update();

    bool success = false;

    try {
      String userID = await PrefsHelper.getString(AppConstants.userId);
      final requestBody = {
        "user_id": userID,
        "otp": otpController.text.trim(),
        "verification_type": verificationType,
      };

      final response = await ApiClient.postData(ApiUrls.verifyOtp, requestBody);
      final responseBody = response.body;

      if (response.statusCode == 201) {
        success = true;
        otpController.clear();
      } else {
        showToast(responseBody['message']);
      }
    } catch (e) {
      showToast('Something went wrong. Please try again.');
      if (kDebugMode) print('VerifyOTP error: $e');
    } finally {
      isLoadingOtp = false;
      update();
    }

    return success;
  }

  /// <======================= login ===========================>
  bool isLoadingLogin = false;
  final TextEditingController loginEmailController = TextEditingController(
    text: kDebugMode ? 'ikramulhasantanvir@gmail.com' : '',
  );
  final TextEditingController loginPasswordController = TextEditingController(
    text: kDebugMode ? '1Qazxsw2@@' : '',
  );

  void cleanFieldLogin() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  Future<void> login() async {
    isLoadingLogin = true;
    update();

    try {
      final requestBody = {
        'email': loginEmailController.text.trim(),
        'password': loginPasswordController.text,
      };

      final response = await ApiClient.postData(
        ApiUrls.login,
        requestBody,
        headers: {'Content-Type': 'application/json'},
      );
      final responseBody = response.body;

      if (response.statusCode == 200) {
        Get.offAllNamed(AppRoutes.bottomNavBar);
        await PrefsHelper.setString(AppConstants.bearerToken, responseBody['token'] ?? '');
        await Get.find<UserController>().userGet();
      } else {
        showToast(responseBody['message']);
      }
    } catch (e) {
      showToast('Something went wrong. Please try again.');
      if (kDebugMode) print('Login error: $e');
    } finally {
      isLoadingLogin = false;
      update();
    }
  }

  /// <======================= forgot ===========================>
  bool isLoadingForgot = false;
  final TextEditingController forgotEmailController = TextEditingController();

  void cleanFieldForgot() {
    forgotEmailController.clear();
  }

  Future<void> forgot() async {
    isLoadingForgot = true;
    update();

    try {
      final requestBody = {'email': forgotEmailController.text.trim()};

      final response = await ApiClient.postData(
        ApiUrls.forgetPassword,
        requestBody,
        headers: {'Content-Type': 'application/json'},
      );
      final responseBody = response.body;

      if (response.statusCode == 201) {
        await PrefsHelper.setString(AppConstants.bearerToken, responseBody['token'] ?? '');
        Get.toNamed(AppRoutes.otpScreen, arguments: 'forgot_password');
        cleanFieldForgot();
      } else {
        showToast(responseBody['message']);
      }
    } catch (e) {
      showToast('Something went wrong. Please try again.');
      if (kDebugMode) print('Forgot error: $e');
    } finally {
      isLoadingForgot = false;
      update();
    }
  }

  /// <======================= reset Password ===========================>
  bool isLoadingReset = false;
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController newResetPasswordController = TextEditingController();

  void cleanFieldReset() async {
    resetPasswordController.clear();
    newResetPasswordController.clear();
    await PrefsHelper.remove(AppConstants.bearerToken);
    await PrefsHelper.remove(AppConstants.role);
  }

  Future<void> resetPassword() async {
    isLoadingReset = true;
    update();

    try {
      final requestBody = {
        'password': newResetPasswordController.text,
        'passwordConfirm': newResetPasswordController.text,
      };

      final response = await ApiClient.postData(
        ApiUrls.resetPassword,
        requestBody,
      );
      final responseBody = response.body;

      if (response.statusCode == 201) {
        Get.offAllNamed(AppRoutes.logInScreen);
        cleanFieldReset();
      } else {
        showToast(responseBody['message']);
      }
    } catch (e) {
      showToast('Something went wrong. Please try again.');
      if (kDebugMode) print('ResetPassword error: $e');
    } finally {
      isLoadingReset = false;
      update();
    }
  }

  /// <======================= Log out ===========================>
  void logOut() async {
    try {
      await PrefsHelper.remove(AppConstants.bearerToken);
      Get.find<UserController>().userData = null;
    } catch (e) {
      if (kDebugMode) print('LogOut error: $e');
    }
  }
}