// lib/views/home/widgets/animated_background.dart

import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'dart:async';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (index) {
      return AnimationController(
        duration: Duration(seconds: 6 + index),
        vsync: this,
      )..repeat(reverse: true);
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: 20).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.darkBackground,
            AppTheme.cardBackground,
            AppTheme.darkBackground,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      // LayoutBuilder istemal karein, ye crash nahi hoga
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          // Agar width ya height 0 hai, to kuch na dikhayein
          if (width == 0 || height == 0) {
            return const SizedBox.shrink();
          }

          return Stack(
            children: List.generate(4, (index) {
              return AnimatedBuilder(
                animation: _animations[index],
                builder: (context, child) {
                  return Positioned(
                    left: [0.1, 0.8, 0.2, 0.9][index] * width,
                    top: [0.1, 0.2, 0.7, 0.3][index] * height,
                    child: Transform.translate(
                      offset: Offset(0, _animations[index].value),
                      child: Container(
                        width: [80, 120, 60, 100][index].toDouble(),
                        height: [80, 120, 60, 100][index].toDouble(),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.primaryBlue,
                              AppTheme.secondaryBlue
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryBlue.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}
