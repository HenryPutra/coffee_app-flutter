// Lokasi file: lib/app/views/order_screen.dart
import 'package:coffee_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/order_controller.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Order',
          style: GoogleFonts.sora(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryToggle(),
            const SizedBox(height: 24),
            _buildSectionTitle('Delivery Address'),
            const SizedBox(height: 16),
            _buildAddressInfo(),
            _buildDivider(),
            Obx(() => _buildOrderItem(controller.coffeeData.value)),
            _buildDivider(),
            _buildDiscountCard(),
            const SizedBox(height: 20),
            _buildSectionTitle('Payment Summary'),
            const SizedBox(height: 16),
            _buildPaymentSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _buildOrderButton(),
    );
  }

  Widget _buildDeliveryToggle() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Obx(
        () => Row(
          children: [
            _buildToggleOption('Deliver', controller.deliveryOption.value),
            _buildToggleOption('Pick Up', controller.deliveryOption.value),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption(String title, String selectedOption) {
    bool isSelected = title == selectedOption;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectDeliveryOption(title),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFC67C4E) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: GoogleFonts.sora(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildAddressInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jl. Kpg Sutoyo',
          style: GoogleFonts.sora(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          'Kpg, Sutoyo No. 620, Bilzen, Tanjungbalai',
          style: GoogleFonts.sora(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildActionButton(Icons.edit, 'Edit Address'),
            const SizedBox(width: 8),
            _buildActionButton(Icons.note_add, 'Add Note'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: Colors.black),
      label: Text(
        label,
        style: GoogleFonts.sora(color: Colors.black, fontSize: 12),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Divider(color: Colors.grey[200], thickness: 1),
    );
  }

  Widget _buildOrderItem(Map<String, String> coffee) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            coffee['image']!,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coffee['name']!,
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                coffee['type']!,
                style: GoogleFonts.sora(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        _buildQuantityButton(Icons.remove, controller.decrement),
        Obx(
          () => Text(
            ' ${controller.quantity.value} ',
            style: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        _buildQuantityButton(Icons.add, controller.increment),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildDiscountCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.discount, color: const Color(0xFFC67C4E)),
          const SizedBox(width: 12),
          Text(
            '1 Discount is Applies',
            style: GoogleFonts.sora(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Obx(
      () => Column(
        children: [
          _buildSummaryRow(
            'Price',
            '\$ ${controller.price.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Fee', style: GoogleFonts.sora()),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.sora(color: Colors.black),
                  children: [
                    const TextSpan(
                      text: '\$ 2.0 ',
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    TextSpan(
                      text: '\$ ${controller.deliveryFee.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildDivider(),
          _buildSummaryRow(
            'Total Payment',
            '\$ ${controller.totalPrice.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.sora()),
        Text(amount, style: GoogleFonts.sora(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildOrderButton() {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.money, color: Color(0xFFC67C4E)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: const Color(0xFFC67C4E),
                child: Text(
                  'Cash',
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Obx(
                () => Text(
                  '\$ ${controller.totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.sora(),
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.DELIVERY);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC67C4E),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Order',
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
