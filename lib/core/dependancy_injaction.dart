import 'package:danceattix/controllers/auth_controller.dart';
import 'package:danceattix/controllers/user_controller.dart';
import 'package:get/get.dart';
class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(UserController());


  }}