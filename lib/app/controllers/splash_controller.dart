import 'package:coffee_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void onGetStartedPressed() {
    Get.offAllNamed(Routes.HOME);
  }
}
