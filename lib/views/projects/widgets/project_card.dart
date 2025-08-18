// features/portfolio/presentation/projects/widgets/project_card.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:my_portfolio/data/models/project.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project}) ;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _imageAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    
    _elevationAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    
    _imageAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;
    
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHovered = true);
              _hoverController.forward();
            },
            onExit: (_) {
              setState(() => _isHovered = false);
              _hoverController.reverse();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isHovered 
                    ? AppTheme.primaryBlue.withOpacity(0.8)
                    : AppTheme.primaryBlue.withOpacity(0.2),
                  width: _isHovered ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(_isHovered ? 0.25 : 0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Image Section with better mobile ratio
                    AspectRatio(
                      aspectRatio: isMobile ? 1.6 : 1.4, // Wider ratio for mobile to leave more space for content
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppTheme.primaryBlue.withOpacity(0.05),
                              AppTheme.secondaryBlue.withOpacity(0.05),
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              // Background Pattern
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      center: Alignment.topRight,
                                      radius: 1.5,
                                      colors: [
                                        AppTheme.primaryBlue.withOpacity(0.1),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Project Image/Mockup with proper scaling
                              Positioned.fill(
                                child: Transform.scale(
                                  scale: _imageAnimation.value,
                                  child: Image.asset(
                                    _getProjectImage(widget.project.title),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              AppTheme.primaryBlue.withOpacity(0.2),
                                              AppTheme.secondaryBlue.withOpacity(0.2),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                _getProjectIcon(widget.project.icon),
                                                size: isMobile ? 40 : 50,
                                                color: AppTheme.primaryBlue.withOpacity(0.7),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                'Mockup',
                                                style: TextStyle(
                                                  color: AppTheme.primaryBlue.withOpacity(0.7),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              
                              // Hover Overlay
                              if (_isHovered)
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          AppTheme.primaryBlue.withOpacity(0.2),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              
                              // GitHub Icon in Top Right Corner
                              if (widget.project.githubUrl != null)
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: GestureDetector(
                                    onTap: () => _launchUrl(widget.project.githubUrl!),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: EdgeInsets.all(isMobile ? 8 : 10),
                                      decoration: BoxDecoration(
                                        color: _isHovered 
                                          ? Colors.black.withOpacity(0.8)
                                          : Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: _isHovered 
                                            ? AppTheme.primaryBlue.withOpacity(0.8)
                                            : Colors.white.withOpacity(0.3),
                                          width: _isHovered ? 2 : 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: _isHovered ? 8 : 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        'assets/icons/github.png',
                                        width: isMobile ? 16 : 20,
                                        height: isMobile ? 16 : 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Content Section - SIGNIFICANTLY IMPROVED for mobile
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(isMobile ? 16 : 20), // More padding for mobile
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title Section (Fixed height)
                            SizedBox(
                              height: isMobile ? 22 : 28, // Fixed height for title
                              child: Text(
                                widget.project.title,
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 18, // Slightly larger for mobile
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primaryBlue,
                                  letterSpacing: -0.5,
                                  height: 1.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            
                            SizedBox(height: isMobile ? 8 : 12),
                            
                            // Description Section (Flexible but with minimum height)
                            Expanded(
                              flex: isMobile ? 3 : 2, // More space for description on mobile
                              child: Text(
                                widget.project.description,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  height: 1.4, // Better line height
                                  fontSize: isMobile ? 12 : 13, // Slightly larger for mobile readability
                                ),
                                maxLines: isMobile ? 5 : 4, // More lines allowed on mobile
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            
                            SizedBox(height: isMobile ? 10 : 12),
                            
                            // Tags Section (Fixed height, will not expand)
                            SizedBox(
                              height: isMobile ? 50 : 30, // More height for mobile tags (allows 2 rows)
                              child: Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: widget.project.tags.take(isMobile ? 5 : 6).map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 8 : 8,
                                      vertical: isMobile ? 4 : 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryBlue.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppTheme.primaryBlue.withOpacity(0.3),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Text(
                                      tag,
                                      style: TextStyle(
                                        color: AppTheme.primaryBlue,
                                        fontSize: isMobile ? 10 : 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getProjectImage(String projectTitle) {
    // Map project titles to your image assets in projects folder
    final titleLower = projectTitle.toLowerCase();
    
    if (titleLower.contains('chat')) {
      return 'assets/projects/chat.jpg';
    } else if (titleLower.contains('task') || titleLower.contains('manager')) {
      return 'assets/projects/taskmanager.jpg';
    } else if (titleLower.contains('islamic') || titleLower.contains('mosque') || titleLower.contains('quran') || titleLower.contains('toolkit')) {
      return 'assets/projects/islamic.jpg';
    } else if (titleLower.contains('place') || titleLower.contains('location') || titleLower.contains('fav')) {
      return 'assets/projects/favplaces.jpg';
    } else if (titleLower.contains('movie') || titleLower.contains('vault')) {
      return 'assets/projects/movievault.jpg';
    } else if (titleLower.contains('meal') || titleLower.contains('food')) {
      return 'assets/projects/meals.jpg';
    } else if (titleLower.contains('deen') || titleLower.contains('kit')) {
      return 'assets/projects/deenkit.png';
    } else {
      // Try to match by checking if any asset exists for the project
      return 'assets/projects/${titleLower.replaceAll(' ', '_').replaceAll('-', '_')}.jpg';
    }
  }

  IconData _getProjectIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'mosque':
        return Icons.mosque;
      case 'chat':
        return Icons.chat_bubble_outline;
      case 'tasks':
      case 'task':
        return Icons.task_alt;
      case 'location':
      case 'place':
        return Icons.location_on;
      case 'movie':
        return Icons.movie_outlined;
      case 'tools':
        return Icons.build_outlined;
      case 'restaurant':
      case 'meals':
        return Icons.restaurant;
      default:
        return Icons.apps;
    }
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}