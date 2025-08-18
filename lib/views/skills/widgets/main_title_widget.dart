import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class MainTitleWidget extends StatelessWidget {
  final bool isMobile;
  final Animation<double> animation;
  final String tagText;
  final String mainTitle;
  final String subtitle;

  const MainTitleWidget({
    super.key,
    required this.isMobile,
    required this.animation,
    required this.tagText,
    required this.mainTitle,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 20,
                    vertical: isMobile ? 6 : 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryBlue.withOpacity(0.1),
                        AppTheme.secondaryBlue.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.primaryBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    tagText,
                    style: TextStyle(
                      color: AppTheme.primaryBlue,
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: isMobile ? 1 : 2,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 16 : 20),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppTheme.primaryBlue,
                      AppTheme.secondaryBlue,
                      const Color(0xFF00BCD4),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    mainTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: isMobile ? 28 : 42,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 16),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}