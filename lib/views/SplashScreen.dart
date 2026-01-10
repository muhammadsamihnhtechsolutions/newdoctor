

import 'package:beh_doctor/theme/AppAssets.dart';
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:beh_doctor/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shareprefs.dart';
import 'BottomNavScreen.dart';

/// 🔹 SplashScreen Widget (MISSING THA)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.4, // zoomed
      end: 1.0, // normal
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
    getToken();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getToken() async {
    String? token = await SharedPrefs.getToken();

    await Future.delayed(const Duration(seconds: 5), () {
      if (token != null && token.isNotEmpty) {
        Get.offAll(() =>  BottomNavScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color008541,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 LOGO WITH ZOOM + FADE
            Expanded(
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      AppAssets.splashLogo,
                     width: MediaQuery.of(context).size.width * 0.75,

                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            /// 🔹 LOADING
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 1.6,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
