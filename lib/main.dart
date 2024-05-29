import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:aplikasi_aksun/views/homepage.dart';
import 'package:aplikasi_aksun/views/login.dart';
import 'package:aplikasi_aksun/views/onboarding.dart';
import 'package:aplikasi_aksun/views/rank.dart';
import 'package:aplikasi_aksun/views/register.dart';
import 'package:aplikasi_aksun/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const LoginView(),
    );
  }
}
