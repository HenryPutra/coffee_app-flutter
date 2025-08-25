// Lokasi file: lib/app/views/detail_screen.dart

import 'package:coffee_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/detail_controller.dart';

class DetailScreen extends GetView<DetailController> {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx(() {
        final coffee = controller.coffeeData.value;
        if (coffee.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(coffee['image']!),
                const SizedBox(height: 20),
                _buildTitleAndInfo(coffee),
                _buildDivider(),
                _buildDescription(),
                _buildSizeSelection(),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBuyButton(),
    );
  }

  /// ✅ AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Detail',
        style: GoogleFonts.sora(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  /// ✅ Gambar Produk
  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imageUrl,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
      ),
    );
  }

  /// ✅ Nama, Info & Rating
  Widget _buildTitleAndInfo(Map<String, String> coffee) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          coffee['name']!,
          style: GoogleFonts.sora(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          coffee['temp'] ?? coffee['type']!,
          style: GoogleFonts.sora(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              coffee['rating']!,
              style: GoogleFonts.sora(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(230)', // Jumlah review hardcode
              style: GoogleFonts.sora(color: Colors.grey[600], fontSize: 12),
            ),
            const Spacer(),
            _buildInfoIcon(Icons.local_cafe),
            const SizedBox(width: 12),
            _buildInfoIcon(Icons.water_drop),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xFFC67C4E)),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Divider(color: Colors.grey[200], thickness: 1),
    );
  }

  /// ✅ Deskripsi Produk
  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: GoogleFonts.sora(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: GoogleFonts.sora(
              color: Colors.grey[600],
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(
                text:
                    'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk... ',
              ),
              TextSpan(
                text: 'Read More',
                style: TextStyle(
                  color: Color(0xFFC67C4E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// ✅ Pilihan Ukuran
  Widget _buildSizeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: GoogleFonts.sora(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            'S',
            'M',
            'L',
          ].map((size) => _buildSizeButton(size)).toList(),
        ),
      ],
    );
  }

  Widget _buildSizeButton(String size) {
    return Obx(() {
      final isSelected = controller.selectedSize.value == size;
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.selectSize(size),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFF5EE) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? const Color(0xFFC67C4E) : Colors.grey[300]!,
              ),
            ),
            child: Text(
              size,
              textAlign: TextAlign.center,
              style: GoogleFonts.sora(
                color: isSelected ? const Color(0xFFC67C4E) : Colors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  /// ✅ Tombol Beli
  Widget _buildBuyButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Harga
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price', style: GoogleFonts.sora(color: Colors.grey[600])),
              const SizedBox(height: 4),
              Text(
                '\$ ${controller.coffeeData.value['price']}',
                style: GoogleFonts.sora(
                  color: const Color(0xFFC67C4E),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          /// Tombol Buy
          ElevatedButton(
            onPressed: () {
              Get.toNamed(
                Routes.ORDER,
                arguments: {
                  'coffee': controller.coffeeData.value,
                  'size': controller.selectedSize.value,
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC67C4E),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Buy Now',
              style: GoogleFonts.sora(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
