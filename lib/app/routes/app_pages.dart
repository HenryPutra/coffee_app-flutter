import 'package:coffee_app/app/bindings/delivery_binding.dart';
import 'package:coffee_app/app/bindings/detail_binding.dart';
import 'package:coffee_app/app/bindings/home_binding.dart';
import 'package:coffee_app/app/bindings/order_binding.dart';
import 'package:coffee_app/app/controllers/splash_controller.dart';
import 'package:coffee_app/app/routes/app_routes.dart';
import 'package:coffee_app/app/screens/delivery_screen.dart';
import 'package:coffee_app/app/screens/detail_screen.dart';
import 'package:coffee_app/app/screens/home_screen.dart';
import 'package:coffee_app/app/screens/order_screen.dart';
import 'package:get/get.dart';
import '../screens/splash_screen.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => const DetailScreen(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => const OrderScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      // <-- TAMBAHKAN BLOK INI
      name: Routes.DELIVERY,
      page: () => const DeliveryScreen(),
      binding: DeliveryBinding(),
    ),
  ];
}
