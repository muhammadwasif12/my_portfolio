import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class AnimatedSectionTitle extends StatelessWidget {
  final String title;
  final bool isMobile;
  final Animation<double> animation;

  const AnimatedSectionTitle({
    super.key,
    required this.title,
    required this.isMobile,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - animation.value), 0),
          child: Opacity(
            opacity: animation.value,
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: isMobile ? 30 : 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryBlue,
                        AppTheme.secondaryBlue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 20 : 32,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}