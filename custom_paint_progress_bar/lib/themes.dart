// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomProgressTheme extends ThemeExtension<CustomProgressTheme> {
  final Color lowerBoundColor;
  final Color upperBoundColor;
  final Color reverseProgressColor;

  final Color backgroundColor;

  final TextTheme? progressTheme;

  CustomProgressTheme(
      {required this.lowerBoundColor,
      required this.upperBoundColor,
      required this.reverseProgressColor,
      required this.backgroundColor,
      this.progressTheme});

  factory CustomProgressTheme.defaultWith(
      {final Color? lowerBoundColor,
      final Color? upperBoundColor,
      final Color? reverseProgressColor,
      final Color? backgroundColor}) {
    return CustomProgressTheme(
        lowerBoundColor: lowerBoundColor ?? Colors.redAccent,
        upperBoundColor: upperBoundColor ?? Colors.greenAccent,
        reverseProgressColor: reverseProgressColor ?? Colors.grey.shade700,
        backgroundColor: Colors.black87);
  }

  static CustomProgressTheme? of(BuildContext context) {
    return Theme.of(context).extension<CustomProgressTheme>();
  }
  @override
  ThemeExtension<CustomProgressTheme> lerp(
      CustomProgressTheme? other, double t) {
    return CustomProgressTheme(
        lowerBoundColor:
            Color.lerp(other?.lowerBoundColor, lowerBoundColor, t)!,
        upperBoundColor:
            Color.lerp(other?.upperBoundColor, upperBoundColor, t)!,
        backgroundColor:
            Color.lerp(other?.backgroundColor, backgroundColor, t)!,
        reverseProgressColor:
            Color.lerp(other?.reverseProgressColor, reverseProgressColor, t)!,
        progressTheme: TextTheme.lerp(other?.progressTheme, progressTheme, t));
  }

  @override
  CustomProgressTheme copyWith({
    Color? lowerBoundColor,
    Color? upperBoundColor,
    Color? reverseProgressColor,
    Color? backgroundColor,
  }) {
    return CustomProgressTheme(
      lowerBoundColor: lowerBoundColor ?? this.lowerBoundColor,
      upperBoundColor: upperBoundColor ?? this.upperBoundColor,
      reverseProgressColor: reverseProgressColor ?? this.reverseProgressColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
