import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class SkillCard extends StatelessWidget {
  final Map<String, dynamic> skill;
  final bool isMobile;
  final Animation<double> progressAnimation;

  const SkillCard({
    super.key,
    required this.skill,
    required this.isMobile,
    required this.progressAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.textSecondary.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Container
              Container(
                width: isMobile ? 48 : 52,
                height: isMobile ? 48 : 52,
                decoration: BoxDecoration(
                  color: skill['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: skill['color'].withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    skill['icon'],
                    width: isMobile ? 24 : 28,
                    height: isMobile ? 24 : 28,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.code,
                        size: isMobile ? 24 : 28,
                        color: skill['color'],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Title and Category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      skill['name'],
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 8 : 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: skill['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        skill['category'],
                        style: TextStyle(
                          color: skill['color'],
                          fontSize: isMobile ? 11 : 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Proficiency Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 16,
                  vertical: isMobile ? 6 : 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      skill['color'],
                      skill['color'].withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: skill['color'].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '${skill['level']}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: isMobile ? 12 : 16),
          
          // Description
          Text(
            skill['description'],
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: isMobile ? 13 : 14,
              height: 1.4,
            ),
          ),
          
          SizedBox(height: isMobile ? 16 : 20),
          
          // Progress Bar Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Proficiency Level',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: isMobile ? 8 : 10),
              
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: isMobile ? 6 : 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: skill['color'].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AnimatedBuilder(
                    animation: progressAnimation,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (skill['level'] / 100) * progressAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                skill['color'].withOpacity(0.8),
                                skill['color'],
                                skill['color'].withOpacity(0.9),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: skill['color'].withOpacity(0.4),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}