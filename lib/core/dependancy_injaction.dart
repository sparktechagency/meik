import 'package:danceattix/controllers/add_product_controller.dart';
import 'package:danceattix/controllers/auth_controller.dart';
import 'package:danceattix/controllers/chat_controller.dart';
import 'package:danceattix/controllers/notification_controller.dart';
import 'package:danceattix/controllers/offer_controller.dart';
import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/controllers/product_details_controller.dart';
import 'package:danceattix/controllers/socket_chat_controller.dart';
import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/services/socket_services.dart';
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
    Get.put(ChatController());
    Get.put(OfferController());
    Get.put(SocketChatController());
    Get.put(SocketServices());


  }}