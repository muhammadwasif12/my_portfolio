// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// DevicePreview ke imports hata diye gaye hain
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:my_portfolio/views/home/portfolio_page.dart';

// main function ko web-safe banayein
void main() async {
  // Ye line web par behtar performance ke liye zaroori hai
  WidgetsFlutterBinding.ensureInitialized();

  // Ab hum seedha ProviderScope aur MyApp ko run karenge
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Is code ko yahan rakhna theek hai, lekin behtar practice ye hai
    // ki isko main() mein rakha jaye. Abhi ke liye koi masla nahi.
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
      // DevicePreview ke builder aur locale hata diye gaye hain
    );
  }
}
