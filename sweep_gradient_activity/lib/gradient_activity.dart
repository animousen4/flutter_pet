// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ActivityPeriod {
  /// value [0..1]
  double activity;

  /// value [0..1]
  double start;

  /// value [0..1]
  double end;

  ActivityPeriod({
    required this.activity,
    required this.start,
    required this.end,
  });
}

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    super.key,
    required this.periods,
  });

  final List<ActivityPeriod> periods;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ActivityPainter(
        baseColor: Colors.red,
        periods: periods,
        spacing: 0.02,
      ),
    );
  }
}

class ActivityPainter extends CustomPainter {
  final Color baseColor;

  Color get transparentBaseColor => baseColor.withOpacity(0.0);

  final List<ActivityPeriod> periods;

  final double spacing;

  ActivityPainter({
    required this.baseColor,
    required this.periods,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.rotate(-pi / 2);

    final paint = Paint();

    final List<Color> colors = [];
    final List<double> stops = [];

    //if (periods.length == 1) {
    colors.add(transparentBaseColor);
    stops.add(periods.first.start);
    //}

    ActivityPeriod previousPeriod = periods.first;

    colors
      ..add(baseColor.withOpacity(previousPeriod.activity))
      ..add(baseColor.withOpacity(previousPeriod.activity));

    stops
      ..add(previousPeriod.start + spacing)
      ..add(previousPeriod.end - spacing);

    for (int i = 1; i < periods.length; i++) {
      final p = periods[i];

      if (previousPeriod.end < p.start) {
        //if (p.start - previousPeriod.end > 2 * spacing) {
        colors
          ..add(baseColor.withOpacity(previousPeriod.activity))
          ..add(transparentBaseColor);
        stops
          ..add(previousPeriod.end + spacing)
          ..add(p.start - spacing);
        //} else {
        // colors
        //   ..add(transparentBaseColor)
        //   ..add(transparentBaseColor);
        // stops
        //   ..add(previousPeriod.end + spacing / 5)
        //   ..add(p.start - spacing / 5);
        //}
      }

      colors
        ..add(baseColor.withOpacity(p.activity))
        ..add(baseColor.withOpacity(p.activity));

      stops
        ..add(p.start + spacing)
        ..add(p.end - spacing);

      previousPeriod = p;
    }
    // colors.add(baseColor.withOpacity(periods.last.activity));
    // colors.add(baseColor.withOpacity(periods.last.activity));

    // stops.add(periods.last.start);
    // stops.add(periods.last.end);

    colors.add(transparentBaseColor);
    stops.add(periods.last.end + spacing);

    final gradient = ui.Gradient.sweep(
      Offset(size.width / 2, size.height / 2),
      colors,
      stops,
    );

    paint.shader = gradient;

    canvas.clipPath(Path()..addOval(Offset.zero & size));
    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
