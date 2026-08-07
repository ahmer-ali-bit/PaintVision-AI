import 'package:flutter/material.dart';
import 'package:paint_vision_ai/screens/ai_feature/ai%20dashboard/upload%20image/crop%20image/crop_image.dart';
import 'package:paint_vision_ai/screens/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/ai%20preview/ai_preview.dart';
import 'package:paint_vision_ai/screens/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/color_palette/ai%20preview/lighting%20preview/lighting_preview.dart';
import 'package:paint_vision_ai/screens/ai_feature/ai%20dashboard/upload%20image/crop%20image/wall%20detection/wall_detection.dart';
import 'package:paint_vision_ai/screens/ai_feature/ai%20dashboard/upload%20image/upload_photo.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/brands.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/home.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home_dashboard.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/offers/offers.dart';
import 'package:paint_vision_ai/screens/onboarding/onboarding_dashboard.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/offers/product%20list/product%20details/product_details.dart';
import 'package:paint_vision_ai/screens/home/home%20dashboard/home/categories/brands/offers/product%20list/product_list.dart';
import 'package:paint_vision_ai/screens/search/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: OnboardingDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
