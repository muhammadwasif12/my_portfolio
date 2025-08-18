// features/portfolio/presentation/pages/portfolio_page.dart
import 'package:flutter/material.dart';
import '../../views/home/widgets/animated_background.dart';
import '../../views/home/widgets/custom_app_bar.dart';
import '../../views/home/widgets/hero_section.dart';
import '../skills/skill_section.dart';
import '../projects/projects_section.dart';
import '../contact/contact_section.dart';
import '../contact/widgets/footer_section.dart';
import '../experience/experience_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (index) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(key: _sectionKeys[0]),
                SkillSection(key: _sectionKeys[1]),
                ProjectsSection(key: _sectionKeys[2]),
                ExperienceSection(key: _sectionKeys[3]),
                ContactSection(key: _sectionKeys[4]),
                const FooterSection(),
              ],
            ),
          ),
          CustomAppBar(onNavigate: _scrollToSection),
        ],
      ),
    );
  }
}