import 'dart:math';

import 'package:flutter/material.dart';

class CustomTick extends StatelessWidget {
  const CustomTick({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return CustomPaint(
            painter:
                CustomTickPainter(animationController: animationController),
          );
        });
  }
}

class CustomTickPainter extends CustomPainter {
  final AnimationController animationController;
  late final Animation<double> introArcAnimation;
  late final Animation<double> greenFirstArcAnimation;
  late final Animation<double> greenSecondArcAnimation;

  late final Animation<double> greenFirstTickAnimation;
  late final Animation<double> greenSecondTickAnimation;
  late final Animation<double> greenFirstFinalTickAnimation;
  late final Animation<double> greenSecondFinalTickAnimation;

  CustomTickPainter({super.repaint, required this.animationController}) {
    introArcAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.10, 0.40)));
    greenFirstArcAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController, curve: const Interval(0.2, 0.6)));
    greenSecondArcAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController, curve: const Interval(0.3, 0.6)));

    greenFirstTickAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController, curve: const Interval(0.3, 0.6)));
    greenSecondTickAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController, curve: const Interval(0.3, 0.6)));
    greenFirstFinalTickAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController, curve: const Interval(0.3, 0.6)));
    greenSecondFinalTickAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController, curve: const Interval(0.3, 0.6)));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 14.0;
    final secondExtraStroke = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final introArcPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
        Offset(strokeWidth / 2, strokeWidth / 2) &
            Size(size.width - strokeWidth, size.height - strokeWidth),
        pi + (pi - pi / 12) * introArcAnimation.value,
        (2 * pi - 3 * pi / 9) * introArcAnimation.value,
        false,
        introArcPaint);

    //if (introArcAnimation.value < 1) return;

    final greenFirstArcPaint = Paint()
      ..color = Colors.green.shade500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
        Offset(strokeWidth / 2, strokeWidth / 2) &
            Size(size.width - strokeWidth, size.height - strokeWidth),
        pi + (pi - pi / 12) * greenFirstArcAnimation.value,
        (2 * pi - 3 * pi / 9) * greenFirstArcAnimation.value,
        false,
        greenFirstArcPaint);

    final greenSecondArcPaint = Paint()
      ..color = Colors.green.shade500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth + secondExtraStroke;

    canvas.drawArc(
        Offset(strokeWidth / 2, strokeWidth / 2) &
            Size(size.width - strokeWidth, size.height - strokeWidth),
        pi + (pi - pi / 12) * greenSecondArcAnimation.value,
        (2 * pi - 3 * pi / 9) * greenSecondArcAnimation.value,
        false,
        greenSecondArcPaint);

    final greenFirstTickPaint = Paint()
      ..color = Colors.red.shade500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth + secondExtraStroke;

    canvas.drawLine(Offset(centerX * 6 / 10, centerY * 8 / 10),
        Offset(centerX * 10 / 10, centerY * 12 / 10), greenFirstTickPaint);

    final greenSecondTickPaint = Paint()
      ..color = Colors.red.shade500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth + secondExtraStroke;

    canvas.drawLine(Offset(centerX * 10 / 10, centerY * 12 / 10),
        Offset(size.width, 0), greenSecondTickPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: refactor from just true
    return true;
  }
}
