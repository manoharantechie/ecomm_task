import 'dart:async';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/core/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    // Load data and navigate
    _onLoad();
  }

  Future<void> _onLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? wel = prefs.getString("welcomeregu");
    String? check = prefs.getString("login");

    // Splash duration
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (check == "1") {
      context.goNamed(AppRoute.home.name);
    }
    // else if (wel == null) {
    //   context.goNamed(AppRoute.onboard.name);
    // }
    else {
      context.goNamed(AppRoute.home.name);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ConstantValues.height(context),
        width: ConstantValues.width(context),
        color: Colors.transparent,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SvgPicture.asset(
                'assets/icons/MVPL_Logo.svg',
                height: 180,
                width: 180,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
