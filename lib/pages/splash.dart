import 'dart:async';

import 'package:finance_app/colors/colors.dart';
import 'package:finance_app/global_variables.dart';
import 'package:finance_app/pages/home_page.dart';
import 'package:finance_app/pages/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await FirstTime.getFirstTime();

      Timer(Duration(seconds: 3), () {
        if (FirstTime.isFirstTime) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnBoarding()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      });
    } catch (e) {
      // Handle any errors in initialization
      print('Error during app initialization: $e');
      // Fallback to home page in case of error
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/svg/logo.svg",
              height: 300,
              width: 300,
            ),
          ),
          Text(
            "Finance App",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
