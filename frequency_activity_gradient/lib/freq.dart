// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class Frequencies {
  /// 0..1 of a selected period
  final List<double> activity;
  Frequencies({
    required this.activity,
  });
}

class FrequenciesCircle extends StatelessWidget {
  const FrequenciesCircle({
    super.key,
    required this.frequencies,
  });

  final Frequencies frequencies;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: FreqienciesCirclePainter(
        pointSpreadFactor: 0.02,
        frequencies: frequencies,
        baseColor: Colors.red,
      ),
    );
  }
}

class FreqienciesCirclePainter extends CustomPainter {
  final Frequencies frequencies;
  final double pointSpreadFactor;
  final Color baseColor;
  FreqienciesCirclePainter({
    required this.frequencies,
    required this.pointSpreadFactor,
    required this.baseColor,
  });

  Color get transparentBaseColor => baseColor.withOpacity(0.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.rotate(-pi / 2);
    canvas.clipPath(Path()..addOval(const Offset(0, 0) & size));

    final List<Color> gradientColors = [];
    final List<double> stops = [];

    if ((1 - frequencies.activity.last) - frequencies.activity.first >=
        pointSpreadFactor) {
      gradientColors.add(transparentBaseColor);
      stops.add(frequencies.activity.first - pointSpreadFactor);
    }

    gradientColors.add(baseColor);
    stops.add(frequencies.activity.first);

    if (frequencies.activity[1] - frequencies.activity.first >=
        pointSpreadFactor) {
      gradientColors.add(transparentBaseColor);
      stops.add(frequencies.activity.first + pointSpreadFactor);
    }

    for (int i = 1; i < frequencies.activity.length - 1; i++) {
      final prevPoint = frequencies.activity[i - 1];
      final point = frequencies.activity[i];
      final nextPoint = frequencies.activity[i + 1];

      if (point - prevPoint >= pointSpreadFactor) {
        gradientColors.add(transparentBaseColor);
        stops.add(point - pointSpreadFactor);
      }
      gradientColors.add(baseColor);
      stops.add(point);
      if (nextPoint - point >= pointSpreadFactor) {
        gradientColors.add(transparentBaseColor);
        stops.add(point + pointSpreadFactor);
      }
    }

    if (frequencies.activity.last -
            frequencies.activity[frequencies.activity.length - 2] >=
        pointSpreadFactor) {
      gradientColors.add(transparentBaseColor);
      stops.add(frequencies.activity[frequencies.activity.length - 1] -
          pointSpreadFactor);
    }

    gradientColors.add(baseColor);
    stops.add(frequencies.activity.last);

    if ((1 - frequencies.activity.last) - frequencies.activity.first >=
        pointSpreadFactor) {
      gradientColors.add(transparentBaseColor);
      stops.add(frequencies.activity.last + pointSpreadFactor);
    }

    final gradientShader = ui.Gradient.sweep(
      Offset(size.width / 2, size.height / 2),
      gradientColors,
      stops,
    );

    final paint = Paint()..shader = gradientShader;

    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant FreqienciesCirclePainter oldDelegate) => false;
}
