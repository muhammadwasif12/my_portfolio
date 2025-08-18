import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double screenWidth;
  final bool isMobile;
  final bool isTablet;
  final bool animateItems;
  final Duration? animationDelay;
  final Curve animationCurve;

  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.screenWidth,
    required this.isMobile,
    required this.isTablet,
    this.animateItems = true,
    this.animationDelay,
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gridConfig = _getGridConfiguration();
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridConfig.crossAxisCount,
            crossAxisSpacing: gridConfig.crossAxisSpacing,
            mainAxisSpacing: gridConfig.mainAxisSpacing,
            childAspectRatio: gridConfig.childAspectRatio,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) {
            if (animateItems) {
              return TweenAnimationBuilder(
                duration: Duration(
                  milliseconds: (animationDelay?.inMilliseconds ?? 600) + (index * 100),
                ),
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: animationCurve,
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: children[index],
                    ),
                  );
                },
              );
            }
            return children[index];
          },
        );
      },
    );
  }

  GridConfiguration _getGridConfiguration() {
    if (screenWidth > 1400) {
      return GridConfiguration(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
      );
    } else if (screenWidth > 1200) {
      return GridConfiguration(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      );
    } else if (screenWidth > 768) {
      return GridConfiguration(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      );
    } else {
      // Mobile configuration
      return GridConfiguration(
        crossAxisCount: 1,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      );
    }
  }
}

class GridConfiguration {
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  GridConfiguration({
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
  });
}