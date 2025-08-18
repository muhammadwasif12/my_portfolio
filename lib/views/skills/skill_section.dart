import 'package:flutter/material.dart';
import 'widgets/animated_grid.dart';
import 'widgets/animated_section_title.dart';
import 'widgets/main_title_widget.dart';
import 'widgets/skill_card.dart';
import 'widgets/tool_card.dart';

class SkillSection extends StatefulWidget {
  const SkillSection({super.key});

  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _cardsController;
  late AnimationController _progressController;
  late Animation<double> _titleAnimation;
  late Animation<double> _cardsAnimation;
  late Animation<double> _progressAnimation;

  final List<Map<String, dynamic>> skills = [
    {
      'name': 'Flutter',
      'icon': 'assets/icons/flutter.png',
      'level': 95,
      'category': 'Framework',
      'color': const Color(0xFF02569B),
      'description': 'Cross-platform mobile development',
    },
    {
      'name': 'Dart',
      'icon': 'assets/icons/dart.png',
      'level': 90,
      'category': 'Language',
      'color': const Color(0xFF0175C2),
      'description': 'Modern programming language',
    },
    {
      'name': 'Firebase',
      'icon': 'assets/icons/firebase.png',
      'level': 85,
      'category': 'Backend',
      'color': const Color(0xFFFFCA28),
      'description': 'Backend as a Service platform',
    },
    {
      'name': 'Supabase',
      'icon': 'assets/icons/supabase.png',
      'level': 85,
      'category': 'Backend',
      'color': const Color(0xFF3ECF8E),
      'description': 'Open source Firebase alternative',
    },
    {
      'name': 'SQLite',
      'icon': 'assets/icons/database.png',
      'level': 80,
      'category': 'Database',
      'color': const Color(0xFF4A90E2),
      'description': 'Lightweight database engine',
    },
    {
      'name': 'MongoDB',
      'icon': 'assets/icons/mongodb.png',
      'level': 80,
      'category': 'Database',
      'color': const Color(0xFF47A248),
      'description': 'NoSQL document database',
    },
    {
      'name': 'REST API',
      'icon': 'assets/icons/restapi.png',
      'level': 80,
      'category': 'Integration',
      'color': const Color(0xFF61DAFB),
      'description': 'RESTful web services',
    },
    {
      'name': 'Java',
      'icon': 'assets/icons/java.png',
      'level': 80,
      'category': 'Language',
      'color': const Color(0xFFED8B00),
      'description': 'Object-oriented programming',
    },
  ];

  final List<Map<String, dynamic>> tools = [
    {
      'name': 'VS Code',
      'icon': 'assets/icons/vscode.png',
      'description': 'Primary IDE',
      'color': const Color(0xFF007ACC),
    },
    {
      'name': 'Android Studio',
      'icon': 'assets/icons/android_studio.png',
      'description': 'Mobile Development',
      'color': const Color(0xFF3DDC84),
    },
    {
      'name': 'GitHub',
      'icon': 'assets/icons/github.png',
      'description': 'Version Control',
      'color': const Color(0xFF333333),
    },
    {
      'name': 'Terminal',
      'icon': 'assets/icons/cli.png',
      'description': 'Command Line',
      'color': const Color(0xFF4A90E2),
    },
    {
      'name': 'Git',
      'icon': 'assets/icons/git.png',
      'description': 'Version Control',
      'color': const Color(0xFFF05032),
    },
    {
      'name': 'Figma',
      'icon': 'assets/icons/figma.png',
      'description': 'UI/UX Design',
      'color': const Color(0xFFF24E1E),
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutCubic),
    );
    
    _cardsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _cardsController, curve: Curves.easeOutCubic),
    );
    
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _cardsController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    _progressController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _cardsController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 40 : 60),
        vertical: isMobile ? 40 : 60,
      ),
      child: Column(
        children: [
          MainTitleWidget(
            isMobile: isMobile,
            animation: _titleAnimation,
            tagText: 'MY EXPERTISE',
            mainTitle: 'Skills & Technologies',
            subtitle: 'Crafting digital experiences with modern technologies',
          ),
          SizedBox(height: isMobile ? 40 : 80),
          _buildSkillsSection(isMobile, isTablet),
          SizedBox(height: isMobile ? 60 : 100),
          _buildToolsSection(isMobile, isTablet),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSectionTitle(
          title: 'Technical Skills',
          isMobile: isMobile,
          animation: _cardsAnimation,
        ),
        SizedBox(height: isMobile ? 24 : 40),
        _buildSkillsGrid(isMobile, isTablet),
      ],
    );
  }

  Widget _buildToolsSection(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSectionTitle(
          title: 'Development Tools',
          isMobile: isMobile,
          animation: _cardsAnimation,
        ),
        SizedBox(height: isMobile ? 24 : 40),
        _buildToolsGrid(isMobile, isTablet),
      ],
    );
  }

  Widget _buildSkillsGrid(bool isMobile, bool isTablet) {
    return AnimatedBuilder(
      animation: _cardsAnimation,
      builder: (context, child) {
        if (isMobile) {
          // Mobile: Single column layout using ListView
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skills.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return AnimatedGridItem(
                index: index,
                animation: _cardsAnimation,
                isSkillCard: true,
                child: SkillCard(
                  skill: skills[index],
                  isMobile: isMobile,
                  progressAnimation: _progressAnimation,
                ),
              );
            },
          );
        } else {
          // Desktop/Tablet: Grid layout
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 1 : 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 20,
              childAspectRatio: isTablet ? 5 : 2.8,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return AnimatedGridItem(
                index: index,
                animation: _cardsAnimation,
                isSkillCard: true,
                child: SkillCard(
                  skill: skills[index],
                  isMobile: isMobile,
                  progressAnimation: _progressAnimation,
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildToolsGrid(bool isMobile, bool isTablet) {
    return AnimatedBuilder(
      animation: _cardsAnimation,
      builder: (context, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 3),
            crossAxisSpacing: isMobile ? 12 : 24,
            mainAxisSpacing: isMobile ? 12 : 24,
            childAspectRatio: isMobile ? 1.1 : 1.3,
          ),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            return AnimatedGridItem(
              index: index,
              animation: _cardsAnimation,
              isSkillCard: false,
              child: ToolCard(
                tool: tools[index],
                isMobile: isMobile,
              ),
            );
          },
        );
      },
    );
  }
}