import 'package:flutter/material.dart';
import 'package:my_portfolio/data/models/experience.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:my_portfolio/data/repositories/experience_data.dart'; // Import the data file
import 'widgets/experience_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    // Clean access to experience data
    final experiences = ExperienceData.getExperiences();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
        vertical: isMobile ? 60 : 80,
      ),
      child: Column(
        children: [
          // Section Title with Enhanced Styling
          _buildSectionTitle(context, isMobile),

          SizedBox(height: isMobile ? 40 : 60),

          // Experience Cards Container
          _buildExperienceList(experiences, isMobile, isTablet),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, bool isMobile) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
          child: Text(
            'Experience',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: isMobile ? 60 : 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Delivering exceptional mobile solutions with cutting-edge technology',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildExperienceList(
    List<Experience> experiences,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: isMobile ? double.infinity : (isTablet ? 900 : 1000),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: experiences.length,
        separatorBuilder:
            (context, index) => SizedBox(height: isMobile ? 20 : 28),
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200 + (index * 100)),
            curve: Curves.easeOutCubic,
            child: ExperienceCard(experience: experiences[index]),
          );
        },
      ),
    );
  }
}