import 'package:flutter/material.dart';
import 'profile_model.dart';
import 'profile_card_page.dart';

void main() => runApp(const ProfileCardApp());

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A90E2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90E2)),
        scaffoldBackgroundColor: const Color(0xFFF2F4F7),
        useMaterial3: true,
      ),
      home: const ProfileCardPage(),
    );
  }
}