import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class ToolCard extends StatelessWidget {
  final Map<String, dynamic> tool;
  final bool isMobile;

  const ToolCard({
    super.key,
    required this.tool,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: tool['color'].withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: tool['color'].withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: isMobile ? 48 : 56,
            height: isMobile ? 48 : 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  tool['color'].withOpacity(0.2),
                  tool['color'].withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: tool['color'].withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Image.asset(
                tool['icon'],
                width: isMobile ? 28 : 32,
                height: isMobile ? 28 : 32,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.build,
                    size: isMobile ? 28 : 32,
                    color: tool['color'],
                  );
                },
              ),
            ),
          ),
          
          SizedBox(height: isMobile ? 12 : 16),
          
          // Tool Name
          Text(
            tool['name'],
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: isMobile ? 4 : 8),
          
          // Description
          Text(
            tool['description'],
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: isMobile ? 11 : 12,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}