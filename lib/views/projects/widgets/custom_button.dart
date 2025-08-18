import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isMobile;
  final String? iconPath;
  final IconData? icon;
  final Color? iconColor;
  final bool showArrow;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isMobile,
    this.iconPath,
    this.icon,
    this.iconColor,
    this.showArrow = true,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 32,
          vertical: isMobile ? 12 : 16,
        ),
        decoration: BoxDecoration(
          gradient: backgroundColor == null ? LinearGradient(
            colors: [
              AppTheme.primaryBlue.withOpacity(0.1),
              AppTheme.secondaryBlue.withOpacity(0.1),
            ],
          ) : null,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderColor ?? AppTheme.primaryBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon (Asset or IconData)
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                width: isMobile ? 18 : 20,
                height: isMobile ? 18 : 20,
                color: iconColor ?? AppTheme.primaryBlue,
              ),
              const SizedBox(width: 12),
            ] else if (icon != null) ...[
              Icon(
                icon,
                color: iconColor ?? AppTheme.primaryBlue,
                size: isMobile ? 18 : 20,
              ),
              const SizedBox(width: 12),
            ],
            
            // Button Text
            Text(
              text,
              style: TextStyle(
                color: textColor ?? AppTheme.primaryBlue,
                fontSize: fontSize ?? (isMobile ? 14 : 16),
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
            ),
            
            // Arrow Icon
            if (showArrow) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_outward_rounded,
                color: textColor ?? AppTheme.primaryBlue,
                size: isMobile ? 16 : 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}