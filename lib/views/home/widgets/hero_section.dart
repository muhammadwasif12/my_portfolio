// lib/views/home/widgets/hero_section.dart

import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  // === ANIMATIONS KAM KAR DI GAYI HAIN ===
  // Sirf background animations ke liye controllers rakhe hain
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Sirf zaroori controllers ko initialize karein
    _floatingController = AnimationController(duration: const Duration(milliseconds: 8000), vsync: this)..repeat(reverse: true);
    _pulseController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this)..repeat(reverse: true);
    _rotationController = AnimationController(duration: const Duration(milliseconds: 20000), vsync: this)..repeat();

    _floatingAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _rotationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final screenWidth = constraints.maxWidth;
        final isMobile = screenWidth < 768;
        final isTablet = screenWidth >= 768 && screenWidth < 1024;

        if (screenWidth == 0 || screenHeight == 0) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              // Background abhi bhi animated rahega
              _buildEnhancedBackground(screenWidth, screenHeight),
              
              // Main Content - BINA KISI ANIMATION KE
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 10 : 20),
                  // Fade, Slide, Scale sab hata diya gaya hai
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: isMobile ? 20 : 30),
                      // Profile picture ab static hai (sirf halka sa pulse karegi)
                      _buildAnimatedProfile(isMobile, isTablet),
                      SizedBox(height: isMobile ? 12 : 18),
                      _buildAnimatedName(isMobile, isTablet),
                      SizedBox(height: isMobile ? 8 : 12),
                      _buildProfessionalTitle(isMobile, isTablet),
                      SizedBox(height: isMobile ? 10 : 14),
                      _buildProfessionalDescription(isMobile, isTablet),
                      SizedBox(height: isMobile ? 12 : 16),
                      _buildProfessionalButtons(isMobile, isTablet),
                      SizedBox(height: isMobile ? 20 : 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ... _buildEnhancedBackground, _buildFloatingBubble, _buildRotatingRing waise hi rahenge ...
  Widget _buildEnhancedBackground(double width, double height) {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _rotationAnimation]),
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 1.5,
                    colors: [
                      AppTheme.primaryBlue.withOpacity(0.1),
                      AppTheme.darkBackground,
                      AppTheme.cardBackground,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
              ...List.generate(12, (index) => _buildFloatingBubble(index, width, height)),
              ...List.generate(3, (index) => _buildRotatingRing(index, width, height)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingBubble(int index, double width, double height) {
    final sizes = [60.0, 80.0, 45.0, 100.0, 35.0, 70.0, 90.0, 50.0, 120.0, 40.0, 65.0, 85.0];
    final positions = [[0.1, 0.2], [0.85, 0.15], [0.2, 0.8], [0.9, 0.7], [0.05, 0.6], [0.75, 0.4], [0.3, 0.1], [0.95, 0.9], [0.15, 0.45], [0.65, 0.85], [0.8, 0.25], [0.4, 0.65]];
    return Positioned(
      left: positions[index][0] * width,
      top: positions[index][1] * height,
      child: Transform.translate(
        offset: Offset(20 * _floatingAnimation.value * (index.isEven ? 1 : -1), 30 * _floatingAnimation.value * (index % 3 == 0 ? 1 : -1)),
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (0.1 * _pulseAnimation.value * (index % 2 == 0 ? 1 : -1)),
              child: Container(
                width: sizes[index],
                height: sizes[index],
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppTheme.primaryBlue.withOpacity(0.3), AppTheme.secondaryBlue.withOpacity(0.2)]),
                  boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.2), blurRadius: 25, spreadRadius: 5)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRotatingRing(int index, double width, double height) {
    final ringSizes = [200.0, 300.0, 400.0];
    final ringOpacities = [0.1, 0.06, 0.04];
    return Positioned(
      left: width / 2 - ringSizes[index] / 2,
      top: height / 2 - ringSizes[index] / 2,
      child: Transform.rotate(
        angle: _rotationAnimation.value * 2 * 3.14159 * (index.isEven ? 1 : -1),
        child: Container(
          width: ringSizes[index],
          height: ringSizes[index],
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.primaryBlue.withOpacity(ringOpacities[index]), width: 2)),
        ),
      ),
    );
  }

  // === BAAKI SAARE WIDGETS AB STATIC HAIN (BINA ANIMATION) ===
  Widget _buildAnimatedProfile(bool isMobile, bool isTablet) {
    final outerRingSize = isMobile ? 150.0 : isTablet ? 170.0 : 190.0;
    final profileContainerSize = isMobile ? 120.0 : isTablet ? 140.0 : 160.0;
    final profileRadius = isMobile ? 58.0 : isTablet ? 68.0 : 78.0;
    return AnimatedBuilder(
      animation: _pulseAnimation, // Sirf pulse animation rakhi hai
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value, // Entrance scale hata diya
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(width: outerRingSize, height: outerRingSize, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: isMobile ? 2 : 3, color: AppTheme.primaryBlue.withOpacity(0.4)))),
              Container(
                width: profileContainerSize,
                height: profileContainerSize,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue]), boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.5), blurRadius: isMobile ? 20 : 25, spreadRadius: isMobile ? 4 : 6)]),
                child: Padding(padding: EdgeInsets.all(isMobile ? 4 : 6), child: CircleAvatar(radius: profileRadius, backgroundImage: const AssetImage('assets/images/profile.jpg'), backgroundColor: Colors.transparent)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedName(bool isMobile, bool isTablet) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue, AppTheme.primaryBlue], stops: const [0.0, 0.5, 1.0]).createShader(bounds),
      child: Text('Muhammad Wasif', style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white, fontSize: isMobile ? 24 : isTablet ? 32 : 38, fontWeight: FontWeight.w800, letterSpacing: 1.5), textAlign: TextAlign.center),
    );
  }

  Widget _buildProfessionalTitle(bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 14, vertical: isMobile ? 5 : 7),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.3), width: 1), gradient: LinearGradient(colors: [AppTheme.primaryBlue.withOpacity(0.1), AppTheme.secondaryBlue.withOpacity(0.1)])),
      child: Text('Flutter Developer | Mobile App Engineer | Firebase Integration Expert', style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppTheme.textSecondary, fontSize: isMobile ? 15 : isTablet ? 17 : 19, fontWeight: FontWeight.w600, letterSpacing: 0.5), textAlign: TextAlign.center),
    );
  }

  Widget _buildProfessionalDescription(bool isMobile, bool isTablet) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? 300 : 520),
      padding: EdgeInsets.all(isMobile ? 10 : 14),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppTheme.cardBackground.withOpacity(0.3), border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2), width: 1)),
      child: Text("I'm a dedicated Flutter Developer and Software Engineering student at COMSATS University Islamabad (CUI), with practical experience in state management (Provider, Riverpod) and Firebase services (Authentication, Firestore, Realtime DB). I specialize in delivering complete, production-grade solutions that are fast, scalable, and maintainable.", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.textTertiary, fontSize: isMobile ? 12 : 14, height: 1.3, letterSpacing: 0.3), textAlign: TextAlign.center),
    );
  }

  Widget _buildProfessionalButtons(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: isMobile ? 260 : 360),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildGitHubButton(isMobile, isTablet)),
          SizedBox(width: isMobile ? 8 : 12),
          Expanded(child: _buildLinkedInButton(isMobile, isTablet)),
        ],
      ),
    );
  }

  Widget _buildGitHubButton(bool isMobile, bool isTablet) {
    return Container(
      height: isMobile ? 34 : 40,
      child: ElevatedButton.icon(
        onPressed: () => _launchUrl('https://github.com/muhammadwasif12' ),
        icon: Image.asset('assets/icons/github.png', width: isMobile ? 13 : 15, height: isMobile ? 13 : 15, color: Colors.white),
        label: Text('GitHub', style: TextStyle(color: Colors.white, fontSize: isMobile ? 10 : 12, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 6, shadowColor: Colors.black.withOpacity(0.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: isMobile ? 4 : 6)),
      ),
    );
  }

  Widget _buildLinkedInButton(bool isMobile, bool isTablet) {
    return Container(
      height: isMobile ? 34 : 40,
      child: ElevatedButton.icon(
        onPressed: () => _launchUrl('https://www.linkedin.com/in/muhammad-wasif-%F0%9F%87%B5%F0%9F%87%B8-b97577347?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app' ),
        icon: Image.asset('assets/icons/linkedin.png', width: isMobile ? 13 : 15, height: isMobile ? 13 : 15),
        label: Text('LinkedIn', style: TextStyle(color: Colors.white, fontSize: isMobile ? 10 : 12, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0077B5), foregroundColor: Colors.white, elevation: 6, shadowColor: const Color(0xFF0077B5).withOpacity(0.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: isMobile ? 4 : 6)),
      ),
    );
  }
}
