import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';

class OrderController extends GetxController {
  final Rx<Map<String, String>> coffeeData = Rx<Map<String, String>>({});
  final RxString selectedSize = 'M'.obs;
  final RxInt quantity = 1.obs;
  final RxString deliveryOption = 'Deliver'.obs;
  final double deliveryFee = 1.0;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      coffeeData.value = Get.arguments['coffee'] as Map<String, String>;
      selectedSize.value = Get.arguments['size'] as String;
    }
  }

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectDeliveryOption(String option) {
    deliveryOption.value = option;
  }

  double get price => double.tryParse(coffeeData.value['price'] ?? '0') ?? 0;
  double get totalPrice => (price * quantity.value) + deliveryFee;
}
