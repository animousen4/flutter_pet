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

  late final Animation<double> greyFirstTickAnimation;
  late final Animation<double> greySecondTickAnimation;

  late final Animation<double> greenFirstTickAnimation;
  late final Animation<double> greenSecondTickAnimation;

  late final Animation<double> greenFirstFinalTickAnimation;
  late final Animation<double> greenSecondFinalTickAnimation;

  CustomTickPainter({required this.animationController}) : super(repaint: animationController) {
    introArcAnimation =
        mapInervalToAnimation(0.10, 0.95, curve: Curves.easeInOutCirc);
    greenFirstArcAnimation =
        mapInervalToAnimation(0.2, 1, curve: Curves.easeInOutCirc);
    greenSecondArcAnimation =
        mapInervalToAnimation(0.45, 1, curve: Curves.easeInOutCirc);

    /////////////////////////////////

    greyFirstTickAnimation = mapInervalToAnimation(0.25, 0.4);
    greySecondTickAnimation = mapInervalToAnimation(0.4, 0.6);

    greenFirstTickAnimation = mapInervalToAnimation(0.55, 0.60);
    greenSecondTickAnimation = mapInervalToAnimation(0.60, 0.8);

    greenFirstFinalTickAnimation = mapInervalToAnimation(0.60, 0.70);
    greenSecondFinalTickAnimation = mapInervalToAnimation(0.70, 1);
  }

  Animation<double> mapInervalToAnimation(double begin, double end,
          {Curve curve = Curves.decelerate}) =>
      Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(begin, end, curve: curve)));

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 15.0;
    final secondExtraStroke = 1.0;

    Paint getBasePaint() {
      return Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;
    }

    final startColor = Color.fromRGBO(242, 242, 247, 1);
    final firstColor = Color.fromRGBO(78, 162, 23, 1);
    final secondaryColor = Color.fromRGBO(53, 152, 70, 1);

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    _drawIntroArc(getBasePaint, startColor, canvas, strokeWidth, size);

    //if (introArcAnimation.value < 1) return;

    _drawFirstArc(getBasePaint, firstColor, canvas, strokeWidth, size);

    _drawSecondArc(
        getBasePaint, firstColor, strokeWidth, secondExtraStroke, canvas, size);

    _drawIntroFirstTick(getBasePaint, startColor, canvas, centerX, centerY);
    _drawIntroSecondTick(getBasePaint, startColor, canvas, centerX, centerY);

    ////////////////////////////////////

    _drawFirstTick(getBasePaint, secondaryColor, canvas, centerX, centerY);

    _drawSecondTick(getBasePaint, secondaryColor, canvas, centerX, centerY);

    _drawFirstFinalTick(getBasePaint, firstColor, canvas, centerX, centerY);

    _drawSecondFinalTick(getBasePaint, firstColor, canvas, centerX, centerY);
  }

  void _drawSecondFinalTick(Paint getBasePaint(), Color firstColor,
      Canvas canvas, double centerX, double centerY) {
    if (greenSecondFinalTickAnimation.value == 0) return;

    final greenSecondFinalTickPaint = getBasePaint()..color = firstColor;

    canvas.drawLine(
        Offset(centerX * 10 / 10, centerY * 12 / 10),
        Offset(centerX * 10 / 10, centerY * 12 / 10) +
            Offset(centerX, -12 / 10 * centerY) *
                greenSecondFinalTickAnimation.value,
        greenSecondFinalTickPaint);
  }

  void _drawFirstFinalTick(Paint getBasePaint(), Color firstColor,
      Canvas canvas, double centerX, double centerY) {
    if (greenFirstFinalTickAnimation.value == 0) return;

    final greenFirstFinalTickPaint = getBasePaint()..color = firstColor;

    canvas.drawLine(
        Offset(centerX * 6 / 10, centerY * 8 / 10),
        Offset(centerX * 6 / 10, centerY * 8 / 10) +
            Offset(centerX * 4 / 10, centerY * 4 / 10) *
                greenFirstFinalTickAnimation.value,
        greenFirstFinalTickPaint);
  }

  void _drawSecondTick(Paint getBasePaint(), Color secondaryColor,
      Canvas canvas, double centerX, double centerY) {
    if (greenSecondTickAnimation.value == 0) return;

    final greenSecondTickPaint = getBasePaint()..color = secondaryColor;

    canvas.drawLine(
        Offset(centerX * 10 / 10, centerY * 12 / 10),
        Offset(centerX * 10 / 10, centerY * 12 / 10) +
            Offset(centerX, -12 / 10 * centerY) *
                greenSecondTickAnimation.value,
        greenSecondTickPaint);
  }

  void _drawFirstTick(Paint getBasePaint(), Color secondaryColor, Canvas canvas,
      double centerX, double centerY) {
    if (greenFirstTickAnimation.value == 0) return;

    final greenFirstTickPaint = getBasePaint()..color = secondaryColor;

    canvas.drawLine(
        Offset(centerX * 6 / 10, centerY * 8 / 10),
        Offset(centerX * 6 / 10, centerY * 8 / 10) +
            Offset(centerX * 4 / 10, centerY * 4 / 10) *
                greenFirstTickAnimation.value,
        greenFirstTickPaint);
  }

  void _drawIntroSecondTick(Paint getBasePaint(), Color startColor,
      Canvas canvas, double centerX, double centerY) {
    if (greySecondTickAnimation.value == 0) return;

    final greySecondTickPaint = getBasePaint()..color = startColor;

    canvas.drawLine(
        Offset(centerX * 10 / 10, centerY * 12 / 10),
        Offset(centerX * 10 / 10, centerY * 12 / 10) +
            Offset(centerX, -12 / 10 * centerY) * greySecondTickAnimation.value,
        greySecondTickPaint);
  }

  void _drawIntroFirstTick(Paint getBasePaint(), Color startColor,
      Canvas canvas, double centerX, double centerY) {
    if (greyFirstTickAnimation.value == 0) return;

    final greyFirstTickPaint = getBasePaint()..color = startColor;

    canvas.drawLine(
        Offset(centerX * 6 / 10, centerY * 8 / 10),
        Offset(centerX * 6 / 10, centerY * 8 / 10) +
            Offset(centerX * 4 / 10, centerY * 4 / 10) *
                greyFirstTickAnimation.value,
        greyFirstTickPaint);
  }

  void _drawSecondArc(Paint getBasePaint(), Color firstColor,
      double strokeWidth, double secondExtraStroke, Canvas canvas, Size size) {
    if (greenSecondArcAnimation.value == 0) return;

    final greenSecondArcPaint = getBasePaint()
      ..color = firstColor
      ..strokeWidth = strokeWidth + secondExtraStroke;

    canvas.drawArc(
        Offset(strokeWidth / 2, strokeWidth / 2) &
            Size(size.width - strokeWidth, size.height - strokeWidth),
        pi + (pi - pi / 12) * greenSecondArcAnimation.value,
        (2 * pi - 3 * pi / 9) * greenSecondArcAnimation.value,
        false,
        greenSecondArcPaint);
  }

  void _drawFirstArc(Paint getBasePaint(), Color firstColor, Canvas canvas,
      double strokeWidth, Size size) {
    if (greenFirstArcAnimation.value == 0) return;

    final greenFirstArcPaint = getBasePaint()..color = firstColor;

    canvas.drawArc(
        Offset(strokeWidth / 2, strokeWidth / 2) &
            Size(size.width - strokeWidth, size.height - strokeWidth),
        pi + (pi - pi / 12) * greenFirstArcAnimation.value,
        (2 * pi - 3 * pi / 9) * greenFirstArcAnimation.value,
        false,
        greenFirstArcPaint);
  }

  void _drawIntroArc(Paint getBasePaint(), Color startColor, Canvas canvas,
      double strokeWidth, Size size) {
    if (introArcAnimation.value == 0) return;

    final introArcPaint = getBasePaint()..color = startColor;

    canvas.drawArc(
        Offset(strokeWidth / 2, strokeWidth / 2) &
            Size(size.width - strokeWidth, size.height - strokeWidth),
        pi + (pi - pi / 12) * introArcAnimation.value,
        (2 * pi - 3 * pi / 9) * introArcAnimation.value,
        false,
        introArcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: refactor from just true
    return true;
  }
}
