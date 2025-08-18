import 'package:flutter/material.dart';
import 'package:my_portfolio/data/models/experience.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class ExperienceCard extends StatefulWidget {
  final Experience experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()
          ..translate(_isHovered && !isMobile ? 12.0 : 0.0, 0.0, 0.0)
          ..scale(_isHovered && !isMobile ? 1.02 : 1.0),
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 0,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(_isHovered ? 0.12 : 0.06),
              Colors.white.withOpacity(_isHovered ? 0.08 : 0.04),
            ],
          ),
          borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
          border: Border.all(
            color: _isHovered 
                ? AppTheme.primaryBlue.withOpacity(0.3)
                : AppTheme.primaryBlue.withOpacity(0.1),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
            border: const Border(
              left: BorderSide(color: AppTheme.primaryBlue, width: 4),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(isMobile, isTablet),
                SizedBox(height: isMobile ? 12 : 16),
                
                // Content Section
                _buildContentSection(isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Period Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 3 : 2,
              child: Text(
                widget.experience.title,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryBlue,
                  height: 1.2,
                ),
                maxLines: isMobile ? 2 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primaryBlue.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.experience.period,
                  style: const TextStyle(
                    color: AppTheme.primaryBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        
        // Company Name
        const SizedBox(height: 6),
        Text(
          widget.experience.company,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 15 : 17,
          ),
        ),
        
        // Period for mobile
        if (isMobile) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              widget.experience.period,
              style: const TextStyle(
                color: AppTheme.primaryBlue,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildContentSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.experience.responsibilities != null &&
            widget.experience.responsibilities!.isNotEmpty) ...[
          // Responsibilities List
          ...widget.experience.responsibilities!.asMap().entries.map((entry) {
            final index = entry.key;
            final responsibility = entry.value;
            
            return AnimatedContainer(
              duration: Duration(milliseconds: 200 + (index * 50)),
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 12),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      responsibility,
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        height: 1.6,
                        fontSize: isMobile ? 14 : 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ] else ...[
          // Description
          Text(
            widget.experience.description,
            style: TextStyle(
              color: AppTheme.textSecondary,
              height: 1.7,
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
