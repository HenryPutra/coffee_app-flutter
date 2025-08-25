// lib/app/controllers/delivery_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  // Dummy data untuk posisi kurir, tujuan, dan rute dalam pixel (Offset)
  // Anda bisa menyesuaikan nilai ini agar pas dengan gambar peta Anda
  final Offset courierPosition = const Offset(80, 250);
  final Offset destinationPosition = const Offset(300, 220);

  final List<Offset> routePoints = const [
    Offset(80, 250),
    Offset(120, 250),
    Offset(120, 230),
    Offset(80, 230),
    Offset(80, 150),
    Offset(300, 150),
    Offset(300, 220),
  ];
}
