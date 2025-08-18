import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CustomAppBar extends StatefulWidget {
  final Function(int) onNavigate;

  const CustomAppBar({super.key, required this.onNavigate}) ;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  bool _isScrolled = false;
  late ScrollController _scrollController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late AnimationController _logoController;
  
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _logoRotation;
  
  int _hoveredIndex = -1;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    // Slide-in animation for app bar
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // Pulse animation for nav items
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // Glow effect animation
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    // Logo rotation animation
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 15000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    _logoRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.linear,
    ));

    // Start animations
    _slideController.forward();
    _pulseController.repeat(reverse: true);
    _glowController.repeat(reverse: true);
    _logoController.repeat();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    
    return SlideTransition(
      position: _slideAnimation,
      child: Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AnimatedBuilder(
          animation: Listenable.merge([_glowController, _logoController]),
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              // Significantly reduced padding for smaller height
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24, 
                vertical: isMobile ? 4 : 6, // Reduced from 8/12 to 4/6
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isScrolled
                      ? [
                          AppTheme.darkBackground.withOpacity(0.95),
                          AppTheme.cardBackground.withOpacity(0.9),
                        ]
                      : [
                          AppTheme.darkBackground.withOpacity(0.8),
                          AppTheme.cardBackground.withOpacity(0.7),
                        ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.primaryBlue.withOpacity(_isScrolled ? 0.3 : 0.1),
                    width: _isScrolled ? 2 : 1,
                  ),
                ),
                boxShadow: _isScrolled
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAnimatedLogo(isMobile),
                    if (!isMobile) _buildNavigationItems(isTablet),
                    if (isMobile) _buildMobileMenu(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo(bool isMobile) {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoRotation, _glowAnimation]),
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) => _logoController.forward(),
          child: GestureDetector(
            onTap: () => widget.onNavigate(0),
            child: Container(
              padding: EdgeInsets.all(isMobile ? 4 : 6), // Reduced padding
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Reduced radius
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryBlue.withOpacity(0.1),
                    AppTheme.secondaryBlue.withOpacity(0.1),
                  ],
                ),
                border: Border.all(
                  color: AppTheme.primaryBlue.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.2 * _glowAnimation.value),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.rotate(
                    angle: _logoRotation.value * 2 * 3.14159,
                    child: Container(
                      width: isMobile ? 20 : 28, // Reduced size
                      height: isMobile ? 20 : 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.code,
                        color: Colors.white,
                        size: isMobile ? 12 : 16, // Reduced icon size
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 6 : 10), // Reduced spacing
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                    ).createShader(bounds),
                    child: Text(
                      'Muhammad Wasif', // More professional full name
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 20, // Reduced font size
                        fontWeight: FontWeight.w700, // Slightly reduced weight
                        color: Colors.white,
                        letterSpacing: 0.8, // Reduced letter spacing
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationItems(bool isTablet) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Row(
          children: List.generate(5, (index) {
            final titles = ['INTRO', 'SKILLS', 'PROJECTS', 'EXPERIENCE', 'CONTACT'];
            final icons = [
              FontAwesomeIcons.house,
              FontAwesomeIcons.user,
              FontAwesomeIcons.folderOpen,
              FontAwesomeIcons.clockRotateLeft,
              FontAwesomeIcons.envelope,
            ];
            
            return _buildNavItem(titles[index], icons[index], index, isTablet);
          }),
        );
      },
    );
  }

  Widget _buildNavItem(String title, IconData icon, int index, bool isTablet) {
    final isSelected = _selectedIndex == index;
    final isHovered = _hoveredIndex == index;
    
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = index),
          onExit: (_) => setState(() => _hoveredIndex = -1),
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onNavigate(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: isTablet ? 3 : 6), // Reduced margin
              padding: EdgeInsets.symmetric(
                vertical: isTablet ? 6 : 8, // Reduced padding
                horizontal: isTablet ? 10 : 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), // Reduced radius
                gradient: isSelected || isHovered
                    ? LinearGradient(
                        colors: [
                          AppTheme.primaryBlue.withOpacity(0.2),
                          AppTheme.secondaryBlue.withOpacity(0.2),
                        ],
                      )
                    : null,
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryBlue.withOpacity(0.5)
                      : isHovered
                          ? AppTheme.primaryBlue.withOpacity(0.3)
                          : Colors.transparent,
                  width: 1,
                ),
                boxShadow: isSelected || isHovered
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              transform: Matrix4.identity()
                ..scale(
                  isHovered ? _pulseAnimation.value : 1.0,
                ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: FaIcon(
                      icon,
                      color: isSelected
                          ? AppTheme.primaryBlue
                          : isHovered
                              ? AppTheme.secondaryBlue
                              : AppTheme.textPrimary.withOpacity(0.8),
                      size: isTablet ? 14 : 16, // Reduced icon size
                    ),
                  ),
                  SizedBox(width: isTablet ? 5 : 6), // Reduced spacing
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.primaryBlue
                          : isHovered
                              ? AppTheme.secondaryBlue
                              : AppTheme.textPrimary.withOpacity(0.9),
                      fontSize: isTablet ? 13 : 14, // Reduced font size
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    child: Text(title),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMenu() {
    return PopupMenuButton<int>(
      icon: FaIcon(
        FontAwesomeIcons.bars,
        color: AppTheme.textPrimary,
        size: 22, // Reduced icon size
      ),
      color: AppTheme.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14), // Reduced radius
        side: BorderSide(
          color: AppTheme.primaryBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      elevation: 20,
      onSelected: (index) {
        setState(() => _selectedIndex = index);
        widget.onNavigate(index);
      },
      itemBuilder: (context) {
        final titles = ['INTRO', 'SKILLS', 'PROJECTS', 'EXPERIENCE', 'CONTACT'];
        final icons = [
          FontAwesomeIcons.house,
          FontAwesomeIcons.user,
          FontAwesomeIcons.folderOpen,
          FontAwesomeIcons.clockRotateLeft,
          FontAwesomeIcons.envelope,
        ];
        
        return List.generate(5, (index) {
          final isSelected = _selectedIndex == index;
          return PopupMenuItem<int>(
            value: index,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduced padding
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Reduced radius
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          AppTheme.primaryBlue.withOpacity(0.1),
                          AppTheme.secondaryBlue.withOpacity(0.1),
                        ],
                      )
                    : null,
              ),
              child: Row(
                children: [
                  FaIcon(
                    icons[index],
                    color: isSelected
                        ? AppTheme.primaryBlue
                        : AppTheme.textPrimary.withOpacity(0.8),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    titles[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.primaryBlue
                          : AppTheme.textPrimary,
                      fontSize: 14, // Reduced font size
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    _glowController.dispose();
    _logoController.dispose();
    super.dispose();
  }
}

