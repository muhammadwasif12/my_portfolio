import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/portfolio_local_data_source.dart';
import 'package:my_portfolio/data/models/project.dart';

// Import reusable widgets
import '../../views/projects/widgets/animated_section_container.dart';
import '../../views/projects/widgets/custom_button.dart';
import '../../views/projects/widgets/project_card.dart';
import '../../views/projects/widgets/responsive_grid.dart';
import '../../views/projects/widgets/section_header.dart';
import '../../views/projects/widgets/url_launcher_helper.dart';


// Riverpod Provider for projects
final projectsProvider = Provider<List<Project>>((ref) {
  final dataSource = PortfolioLocalDataSource();
  return dataSource.getProjects();
});

class ProjectsSection extends ConsumerStatefulWidget {
  const ProjectsSection({super.key});

  @override
  ConsumerState<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends ConsumerState<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Your GitHub username - change this to your actual username
  static const String githubUsername = 'muhammadwasif12';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    // Start animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(projectsProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return AnimatedSectionContainer(
          fadeAnimation: _fadeAnimation,
          slideAnimation: _slideAnimation,
          isMobile: isMobile,
          isTablet: isTablet,
          child: Column(
            children: [
              // Section Header
              SectionHeader(
                subtitle: 'My Work',
                mainTitle: 'Featured Projects',
                description: 'Here are some of my recent projects that showcase my skills and experience in mobile development.',
                isMobile: isMobile,
              ),
              
              SizedBox(height: isMobile ? 32 : 48),
              
              // Projects Grid
              ResponsiveGrid(
                screenWidth: screenWidth,
                isMobile: isMobile,
                isTablet: isTablet,
                children: projects.map((project) => ProjectCard(project: project)).toList(),
              ),
              
              SizedBox(height: isMobile ? 20 : 40),
              
              // View More Button
              CustomButton(
                text: 'View All on GitHub',
                onTap: () => UrlLauncherHelper.launchGitHub(githubUsername),
                isMobile: isMobile,
                iconPath: 'assets/icons/github.png',
              ),
            ],
          ),
        );
      },
    );
  }
}