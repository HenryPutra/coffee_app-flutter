import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/coffee_background.png'),
            fit: BoxFit.cover,
            // Mengatur posisi gambar agar lebih ke atas
            alignment: Alignment(0.0, -0.3),
          ),
        ),
        child: Stack(
          children: [
            // Additional floating coffee beans effect
            ...List.generate(15, (index) => _buildFloatingCoffeeBean(index)),

            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 4),

                  // Title
                  Text(
                    'Fall in Love with\nCoffee in Blissful\nDelight!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      height: 1.2,
                      letterSpacing: -0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Subtitle
                  Text(
                    'Welcome to our cozy coffee corner, where\nevery cup is a delightful for you.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.4,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Get Started Button
                  _buildGetStartedButton(context),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCoffeeBean(int index) {
    final double size = 4 + (index % 3) * 2;
    final double left = (index * 37) % (Get.width);
    final double top = (index * 67) % (Get.height);

    return Positioned(
      left: left,
      top: top,
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 3000 + (index * 100)),
        tween: Tween(begin: 0.0, end: 1.0),
        onEnd: () {},
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(
              Math.sin(value * 2 * Math.pi) * 10, // Horizontal float
              (value * 20) - 10, // Vertical float
            ),
            child: Transform.rotate(
              angle: value * Math.pi, // Half rotation
              child: Opacity(
                opacity: 0.4 + (value * 0.3),
                child: Container(
                  width: size,
                  height: size * 1.2,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(size / 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.8),
            AppTheme.primaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: controller.onGetStartedPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          'Get Started',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
