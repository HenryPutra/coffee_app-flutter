// Lokasi file: lib/app/views/delivery_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/delivery_controller.dart';

class DeliveryScreen extends GetView<DeliveryController> {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang peta statis
          Image.asset(
            'assets/images/map_background.png', // GANTI DENGAN GAMBAR PETA ANDA
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // Custom painter untuk menggambar rute dan pin
          CustomPaint(
            painter: MapPainter(
              routePoints: controller.routePoints,
              courierPosition: controller.courierPosition,
              destinationPosition: controller.destinationPosition,
            ),
            size: Size.infinite,
          ),

          // Tombol kembali
          Positioned(
            top: 50,
            left: 24,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          // Tombol lokasi
          Positioned(
            top: 50,
            right: 24,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.gps_fixed, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
          // Panel bawah
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: _buildBottomPanel(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '10 minutes left',
            style: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: GoogleFonts.sora(color: Colors.grey[600], fontSize: 12),
              children: const [
                TextSpan(text: 'Delivery to '),
                TextSpan(
                  text: 'Jl. Kpg Sutoyo',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.7, // Contoh progress
              backgroundColor: Color(0xFFEAEAEA),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 20),
          _buildDeliveryStatusCard(),
          const SizedBox(height: 20),
          _buildCourierInfo(),
        ],
      ),
    );
  }

  Widget _buildDeliveryStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.delivery_dining,
              color: Color(0xFFC67C4E),
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivered your order',
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'We will deliver your goods in the shortest possible time.',
                  style: GoogleFonts.sora(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourierInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 27,
          backgroundImage: AssetImage(
            'assets/images/courier_profile.png',
          ), // GANTI GAMBAR
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brooklyn Simmons',
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Personal Courier',
                style: GoogleFonts.sora(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.call_outlined, color: Color(0xFFC67C4E)),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

// Custom Painter to draw the route and pins on the map image
class MapPainter extends CustomPainter {
  final List<Offset> routePoints;
  final Offset courierPosition;
  final Offset destinationPosition;

  MapPainter({
    required this.routePoints,
    required this.courierPosition,
    required this.destinationPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the route line
    final routePaint = Paint()
      ..color = const Color(0xFFC67C4E)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the route
    final path = Path();
    if (routePoints.isNotEmpty) {
      path.moveTo(routePoints.first.dx, routePoints.first.dy);
      for (var i = 1; i < routePoints.length; i++) {
        path.lineTo(routePoints[i].dx, routePoints[i].dy);
      }
    }
    canvas.drawPath(path, routePaint);

    // Paint for the pins
    final pinPaint = Paint()..color = const Color(0xFFC67C4E);
    final whitePaint = Paint()..color = Colors.white;

    // Draw destination pin (house icon)
    canvas.drawCircle(destinationPosition, 12, pinPaint);
    canvas.drawCircle(destinationPosition, 9, whitePaint);
    const IconData homeIcon = Icons.home_filled;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(homeIcon.codePoint),
      style: TextStyle(
        fontSize: 14.0,
        fontFamily: homeIcon.fontFamily,
        color: const Color(0xFFC67C4E),
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(destinationPosition.dx - 7, destinationPosition.dy - 7),
    );

    // Draw courier pin
    canvas.drawCircle(courierPosition, 8, pinPaint);
    canvas.drawCircle(courierPosition, 5, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
