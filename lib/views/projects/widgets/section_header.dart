import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String subtitle;
  final String mainTitle;
  final String description;
  final bool isMobile;
  final bool showDecorativeLine;
  final double? maxWidth;

  const SectionHeader({
    super.key,
    required this.subtitle,
    required this.mainTitle,
    required this.description,
    required this.isMobile,
    this.showDecorativeLine = true,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Subtitle
        Text(
          subtitle,
          style: TextStyle(
            color: AppTheme.primaryBlue.withOpacity(0.8),
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
        
        SizedBox(height: isMobile ? 8 : 12),
        
        // Main Title with Gradient
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppTheme.primaryBlue,
              AppTheme.secondaryBlue,
              AppTheme.primaryBlue.withOpacity(0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: Text(
            mainTitle,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        SizedBox(height: isMobile ? 12 : 16),
        
        // Description
        Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? (isMobile ? 300 : 600),
          ),
          child: Text(
            description,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: isMobile ? 14 : 16,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        if (showDecorativeLine) ...[
          SizedBox(height: isMobile ? 16 : 24),
          
          // Decorative Line
          Container(
            width: isMobile ? 60 : 80,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ],
    );
  }
}