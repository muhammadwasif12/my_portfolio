import 'package:flutter/material.dart';

class AnimatedGridItem extends StatelessWidget {
  final Widget child;
  final int index;
  final Animation<double> animation;
  final bool isSkillCard;

  const AnimatedGridItem({
    super.key,
    required this.child,
    required this.index,
    required this.animation,
    this.isSkillCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final delay = index * 0.1;
    final animationValue = (animation.value - delay).clamp(0.0, 1.0);

    if (isSkillCard) {
      return Transform.translate(
        offset: Offset(50 * (1 - animationValue), 0),
        child: Opacity(
          opacity: animationValue,
          child: child,
        ),
      );
    } else {
      return Transform.scale(
        scale: 0.8 + (0.2 * animationValue),
        child: Opacity(
          opacity: animationValue,
          child: child,
        ),
      );
    }
  }
}