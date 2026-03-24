import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int selectedIndex = 0;

  void onChange(int index) {
    selectedIndex = index;
    update();
  }
}