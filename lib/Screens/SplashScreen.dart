import 'dart:async';
import 'package:flutter/material.dart';

import '../main.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> leftDoor;
  late Animation<double> rightDoor;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    leftDoor = Tween<double>(
      begin: 0,
      end: -1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    rightDoor = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    Timer(const Duration(seconds: 3), () async {
      await controller.forward();

      final session = supabase.auth.currentSession;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              session != null ? const HomeScreen() : const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Center(
            child: Icon(Icons.newspaper, size: 90, color: Colors.blue),
          ),

          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Transform.translate(
                    offset: Offset(leftDoor.value * width / 2, 0),
                    child: Container(
                      width: width / 2,
                      height: double.infinity,
                      color: Colors.blue,
                    ),
                  ),

                  Transform.translate(
                    offset: Offset(rightDoor.value * width / 2, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: width / 2,
                        height: double.infinity,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          const Center(
            child: Text(
              "Important News",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
