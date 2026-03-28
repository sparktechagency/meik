import 'package:danceattix/controllers/add_product_controller.dart';
import 'package:danceattix/controllers/auth_controller.dart';
import 'package:danceattix/controllers/boost_controller.dart';
import 'package:danceattix/controllers/chat_controller.dart';
import 'package:danceattix/controllers/checkout_controller.dart';
import 'package:danceattix/controllers/fvrt_product_controller.dart';
import 'package:danceattix/controllers/notification_controller.dart';
import 'package:danceattix/controllers/offer_controller.dart';
import 'package:danceattix/controllers/payment_controller.dart';
import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/controllers/product_details_controller.dart';
import 'package:danceattix/controllers/socket_chat_controller.dart';
import 'package:danceattix/controllers/terms_and_condition_controller.dart';
import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/controllers/wallet_controller.dart';
import 'package:danceattix/views/screens/bottom_nav_bar/bottom_nav_controller.dart';
import 'package:get/get.dart';
class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(ProductController());
    Get.put(AddProductController());
    Get.put(ProductDetailsController());
    Get.put(NotificationController());
    Get.put(ChatsController());
    Get.put(OfferController());
    Get.put(SocketChatController());
    Get.put(FvrtProductController());
    Get.put(WalletController());
    Get.put(PaymentController());
    Get.put(CheckoutController());
    Get.put(BoostController());
    Get.put(BottomNavController());
    Get.put(TermsAndConditionController());


  }}