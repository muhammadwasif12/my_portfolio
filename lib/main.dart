// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:my_portfolio/views/home/portfolio_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: false, // Disable in release build if you want
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0F1419),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Muhammad Wasif - Flutter Developer',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const PortfolioPage(),
      // DevicePreview integration
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}
