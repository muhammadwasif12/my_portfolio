import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class AnimatedSectionContainer extends StatelessWidget {
  final Widget child;
  final bool isMobile;
  final bool isTablet;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final bool hasGradientBackground;

  const AnimatedSectionContainer({
    super.key,
    required this.child,
    required this.isMobile,
    required this.isTablet,
    required this.fadeAnimation,
    required this.slideAnimation,
    this.padding,
    this.backgroundColor,
    this.backgroundGradient,
    this.hasGradientBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          width: double.infinity,
          padding: padding ?? EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
            vertical: isMobile ? 40 : 60,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: hasGradientBackground ? (backgroundGradient ?? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppTheme.primaryBlue.withOpacity(0.02),
                Colors.transparent,
              ],
            )) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}