import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:aplikasi_aksun/views/homepage.dart';
import 'package:aplikasi_aksun/views/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: greenColor),
        useMaterial3: true,
      ),
      home: const HomePageView(),
    );
  }
}
