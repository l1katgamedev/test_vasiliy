import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_vasiliy/core/env.dart';
import 'package:test_vasiliy/presentation/screens/news_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 1000), () async {
      prefs = await SharedPreferences.getInstance();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const NewsScreen()), (Route<dynamic> route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}
