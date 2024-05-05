// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:custom_paint_progress_bar/themes.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  CustomProgressBar({super.key, required this.progress}) {
    assert(progress >= 0 && progress <= 1);
  }

  final double progress;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomProgressTheme>() ??
        CustomProgressTheme.defaultWith();
    final textStyle = theme.progressTheme?.titleLarge ??
        Theme.of(context).textTheme.titleLarge!;

    final percentage = (progress * 100).toStringAsFixed(2);
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: ProgressBarPainter(
              progress: progress,
              progressPadding: 5,
              strokeWidth: 3,
              theme: theme),
        ),
        Center(
            child: DefaultTextStyle(
                style: textStyle,
                child: Text(
                  "$percentage%",
                  style: textStyle,
                ))),
      ],
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final double progress;
  final double progressPadding;
  final double strokeWidth;

  final CustomProgressTheme theme;

  ProgressBarPainter(
      {required this.progress,
      required this.progressPadding,
      required this.strokeWidth,
      required this.theme,
      super.repaint});

  @override
  void paint(Canvas canvas, Size size) {
    final commonArcRect = calculateArcRect(size);
    drawBackgroundCircle(canvas, size);
    drawReverseProgress(canvas, size, commonArcRect);
    drawProgress(canvas, size, commonArcRect);
  }

  Rect calculateArcRect(Size size) {
    return Offset(progressPadding + strokeWidth / 2,
            progressPadding + strokeWidth / 2) &
        Size(size.width - 2 * progressPadding - strokeWidth / 2,
            size.height - 2 * progressPadding - strokeWidth / 2);
  }

  void drawBackgroundCircle(Canvas canvas, Size size) {
    final circleCenter = Offset(size.width / 2, size.height / 2);
    final circleRadius = size.width / 2;

    final paint = Paint()
      ..color = theme.backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(circleCenter, circleRadius, paint);
  }

  void drawProgress(Canvas canvas, Size size, Rect arcRect) {
    final paint = Paint()
      ..color = mapProgressToColor()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(arcRect, -pi / 2, 2 * pi * progress, false, paint);
  }

  void drawReverseProgress(Canvas canvas, Size size, Rect arcRect) {
    final paint = Paint()
      ..color = theme.reverseProgressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(arcRect, -pi / 2 + 2 * pi * progress,
        2 * pi * (1 - progress), false, paint);
  }

  Color mapProgressToColor() {
    return Color.lerp(theme.lowerBoundColor, theme.upperBoundColor, progress)!;
  }

  @override
  bool shouldRepaint(covariant ProgressBarPainter oldDelegate) {
    return true;
  }
}
