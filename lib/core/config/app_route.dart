

import 'package:danceattix/views/screens/product/add_product_variant_screen.dart';
import 'package:get/get.dart';

import '../../views/screens/auth/enable_location/enable_location_screen.dart';
import '../../views/screens/auth/forgot/forgot_screen.dart';
import '../../views/screens/auth/login/login_screen.dart';
import '../../views/screens/auth/otp/opt_screen.dart';
import '../../views/screens/auth/reset/reset_password_screen.dart';
import '../../views/screens/auth/sing_up/sign_up_screen.dart';
import '../../views/screens/auth/upload_nid/upload_nid_screen.dart';
import '../../views/screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../../views/screens/product/all_product_screen.dart';
import '../../views/screens/home/cart_screen.dart';
import '../../views/screens/product/product_details_screen.dart';
import '../../views/screens/home/progress_screen.dart';
import '../../views/screens/message/chat_profile_screen.dart';
import '../../views/screens/message/media_screen.dart';
import '../../views/screens/message/message_screen.dart';
import '../../views/screens/notification/notification_screen.dart';
import '../../views/screens/onboarding/onboarding_screen.dart';
import '../../views/screens/product/boost_screen.dart';
import '../../views/screens/product/create_product_screen.dart';
import '../../views/screens/profile/edit_profile_screen.dart';
import '../../views/screens/profile/profile_information_screen.dart';
import '../../views/screens/profile/profile_screen.dart';
import '../../views/screens/profile/wallet_history_screen.dart';
import '../../views/screens/profile/wallet_screen.dart';
import '../../views/screens/profile/wish_list_screen.dart';
import '../../views/screens/purchas/confirm_purchase_screen.dart';
import '../../views/screens/purchas/confirmed.dart';
import '../../views/screens/purchas/make_payment.dart';
import '../../views/screens/refund/refund_request_screen.dart';
import '../../views/screens/setting/change_password_screen.dart';
import '../../views/screens/setting/privacy_policy_all_screen.dart';
import '../../views/screens/setting/setting_screen.dart';
import '../../views/screens/splash/splash_screen.dart';


class AppRoutes {
  static const String splashScreen = "/SplashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String logInScreen = "/LogInScreen";
  static const String forgotScreen = "/ForgotScreen";
  static const String otpScreen = "/OptScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String enableLocationScreen = "/EnableLocationScreen";
  static const String uploadNIDScreen = "/UploadNIDScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String messageScreen = "/MessageScreen";
  static const String allProductScreen = "/AllProductScreen";
  static const String productDetailsScreen = "/ProductDetailsScreen";
  static const String cartScreen = "/CartScreen";
  static const String confirmPurchaseScreen = "/ConfirmPurchaseScreen";
  static const String makePayment = "/MakePayment";
  static const String confirmed = "/Confirmed";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String profileInformationScreen = "/ProfileInformationScreen";
  static const String settingScreen = "/SettingScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String privacyPolicyAllScreen = "/PrivacyPolicyAllScreen";
  static const String walletScreen = "/WalletScreen";
  static const String walletHistoryScreen = "/WalletHistoryScreen";
  static const String chatProfileScreen = "/ChatProfileScreen";
  static const String mediaScreen = "/MediaScreen";
  static const String refundRequestScreen = "/RefundRequestScreen";
  static const String wishListScreen = "/WishListScreen";
  static const String bottomNavBar = "/BottomNavBar";
  static const String progressScreen = "/ProgressScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String createProductScreen = "/CreateProductScreen";
  static const String boostScreen = "/BoostScreen";
  static const String addProductVariantScreen = "/addProductVariantScreen";



  static List<GetPage> get routes => [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () =>  OnboardingScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: logInScreen, page: () =>  LogInScreen()),
    GetPage(name: forgotScreen, page: () =>  ForgotScreen()),
    GetPage(name: otpScreen, page: () =>  OptScreen()),
    GetPage(name: resetPasswordScreen, page: () =>  ResetPasswordScreen()),
    GetPage(name: enableLocationScreen, page: () =>  EnableLocationScreen()),
    GetPage(name: uploadNIDScreen, page: () => const UploadNIDScreen()),
    GetPage(name: notificationScreen, page: () =>  NotificationScreen()),
    GetPage(name: messageScreen, page: () =>  MessageScreen()),
    GetPage(name: allProductScreen, page: () => const AllProductScreen()),
    GetPage(name: productDetailsScreen, page: () => const ProductDetailsScreen()),
    GetPage(name: cartScreen, page: () =>  CartScreen()),
    GetPage(name: confirmPurchaseScreen, page: () =>  ConfirmPurchaseScreen()),
    GetPage(name: makePayment, page: () =>  MakePayment()),
    GetPage(name: confirmed, page: () =>  Confirmed()),
    GetPage(name: editProfileScreen, page: () =>  EditProfileScreen()),
    GetPage(name: profileInformationScreen, page: () =>  ProfileInformationScreen()),
    GetPage(name: settingScreen, page: () =>  SettingScreen()),
    GetPage(name: changePasswordScreen, page: () =>  ChangePasswordScreen()),
    GetPage(name: privacyPolicyAllScreen, page: () =>  PrivacyPolicyAllScreen()),
    GetPage(name: walletScreen, page: () =>  WalletScreen()),
    GetPage(name: walletHistoryScreen, page: () =>  WalletHistoryScreen()),
    GetPage(name: chatProfileScreen, page: () =>  ChatProfileScreen()),
    GetPage(name: mediaScreen, page: () =>  MediaScreen()),
    GetPage(name: refundRequestScreen, page: () =>  RefundRequestScreen()),
    GetPage(name: wishListScreen, page: () =>  WishListScreen()),
    GetPage(name: bottomNavBar, page: () => const BottomNavBar()),
    GetPage(name: progressScreen, page: () =>  ProgressScreen()),
    GetPage(name: profileScreen, page: () =>  ProfileScreen()),
    GetPage(name: createProductScreen, page: () =>  AddProductScreen()),
    GetPage(name: addProductVariantScreen, page: () =>  AddProductVariantScreen()),
    GetPage(name: boostScreen, page: () => const BoostScreen()),
  ];
}
