import 'package:get/get.dart';

class HomeController extends GetxController {
  // Data untuk item-item kopi
  final List<Map<String, String>> coffeeList = [
    {
      'name': 'Caffe Mocha',
      'type': 'Deep Foam',
      'price': '4.53',
      'image':
          'assets/images/coffee_mocha.png', // Ganti dengan path gambar Anda
      'rating': '4.8',
    },
    {
      'name': 'Flat White',
      'type': 'Espresso',
      'price': '3.53',
      'image': 'assets/images/flat_white.png', // Ganti dengan path gambar Anda
      'rating': '4.8',
    },
    {
      // <-- ITEM BARU DITAMBAHKAN
      'name': 'Mocha Fusi',
      'type': 'Chocolate',
      'price': '5.12',
      'image': 'assets/images/mocha_fusi.png', // Ganti dengan path gambar Anda
      'rating': '4.7',
      'temp': 'Ice/Hot', // Data tambahan
    },
    {
      // <-- ITEM BARU DITAMBAHKAN
      'name': 'Caffe Panna',
      'type': 'Creamy',
      'price': '4.80',
      'image': 'assets/images/caffe_panna.png', // Ganti dengan path gambar Anda
      'rating': '4.9',
      'temp': 'Ice/Hot', // Data tambahan
    },
  ];

  // Variabel untuk melacak kategori yang dipilih
  final RxInt selectedCategoryIndex = 0.obs;

  // List kategori yang bisa di-scroll
  final RxList<String> categories = <String>[
    'All Coffee',
    'Machiatto',
    'Latte',
    'Americano',
  ].obs;

  // Fungsi untuk mengubah kategori yang dipilih
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
