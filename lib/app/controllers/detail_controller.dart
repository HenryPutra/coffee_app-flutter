import 'package:get/get.dart';

class DetailController extends GetxController {
  final Rx<Map<String, String>> coffeeData = Rx<Map<String, String>>({});
  final RxString selectedSize = 'M'.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      coffeeData.value = Get.arguments as Map<String, String>;
    }
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }
}
