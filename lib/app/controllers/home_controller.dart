import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<Map<String, String>> coffeeList = [
    {
      'name': 'Caffe Mocha',
      'type': 'Deep Foam',
      'price': '4.53',
      'image': 'assets/images/coffee_mocha.png',
      'rating': '4.8',
    },
    {
      'name': 'Flat White',
      'type': 'Espresso',
      'price': '3.53',
      'image': 'assets/images/flat_white.png',
      'rating': '4.8',
    },
    {
      'name': 'Mocha Fusi',
      'type': 'Chocolate',
      'price': '5.12',
      'image': 'assets/images/mocha_fusi.png',
      'rating': '4.7',
      'temp': 'Ice/Hot',
    },
    {
      'name': 'Caffe Panna',
      'type': 'Creamy',
      'price': '4.80',
      'image': 'assets/images/caffe_panna.png',
      'rating': '4.9',
      'temp': 'Ice/Hot',
    },
  ];

  final RxInt selectedCategoryIndex = 0.obs;

  final RxList<String> categories = <String>[
    'All Coffee',
    'Machiatto',
    'Latte',
    'Americano',
  ].obs;

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
