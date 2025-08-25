import 'package:coffee_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  // Menghilangkan onInit() yang menyebabkan navigasi otomatis.
  // Sekarang, navigasi hanya akan terjadi saat tombol ditekan.

  void onGetStartedPressed() {
    // Pindah ke halaman beranda dan hapus splash screen dari riwayat navigasi
    Get.offAllNamed(Routes.HOME);
  }
}
