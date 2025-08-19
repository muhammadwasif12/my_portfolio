import 'dart:async'; // Timer ke liye import karein

import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  // Ek flag banayein taaki animation foran shuru na ho
  bool _isReady = false;

  @override
  void initState() {
    super.initState();

    // initState mein animation controllers ko sirf initialize karein, repeat() na karein
    _controllers = List.generate(4, (index) {
      return AnimationController(
        duration: Duration(seconds: 6 + index),
        vsync: this,
      );
    });

    _animations =
        _controllers.map((controller) {
          return Tween<double>(begin: 0, end: 20).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          );
        }).toList();

    // Sabse zaroori: Ek chhota sa delay dein taaki pehla frame build ho jaye
    // Iske baad hi animation shuru karein
    Timer(const Duration(milliseconds: 100), () {
      if (mounted) {
        // Check karein ki widget abhi bhi screen par hai
        setState(() {
          _isReady = true; // Ab UI ko batayein ki animation ke liye taiyar hai
        });
        for (var controller in _controllers) {
          controller.repeat(reverse: true); // Ab animation shuru karein
        }
      }
    });
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
      // Agar ready nahi hai, to kuch na dikhayein, taaki crash na ho
      child:
          _isReady
              ? Stack(
                children: List.generate(4, (index) {
                  // ... baaki ka code bilkul waisa hi ...
                  return AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      return Positioned(
                        left:
                            [0.1, 0.8, 0.2, 0.9][index] *
                            MediaQuery.of(context).size.width,
                        top:
                            [0.1, 0.2, 0.7, 0.3][index] *
                            MediaQuery.of(context).size.height,
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
                                  AppTheme.secondaryBlue,
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
              )
              : const SizedBox.shrink(), // Jab tak ready na ho, ek khaali box dikhayein
    );
  }
}
