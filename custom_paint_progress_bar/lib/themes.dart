// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomProgressTheme extends ThemeExtension<CustomProgressTheme> {
  final Color? lowerBoundColor;
  final Color? upperBoundColor;
  final Color? reverseProgressColor;

  final Color? backgroundColor;

  CustomProgressTheme(
      {this.lowerBoundColor,
      this.upperBoundColor,
      this.reverseProgressColor,
      this.backgroundColor});

  @override
  ThemeExtension<CustomProgressTheme> lerp(
      CustomProgressTheme? other, double t) {
    return CustomProgressTheme(
        lowerBoundColor: Color.lerp(other?.lowerBoundColor, lowerBoundColor, t),
        upperBoundColor:
            Color.lerp(other?.upperBoundColor, upperBoundColor, t));
  }

  @override
  CustomProgressTheme copyWith({
    Color? lowerBoundColor,
    Color? upperBoundColor,
  }) {
    return CustomProgressTheme(
      lowerBoundColor: lowerBoundColor ?? this.lowerBoundColor,
      upperBoundColor: upperBoundColor ?? this.upperBoundColor,
    );
  }
}
