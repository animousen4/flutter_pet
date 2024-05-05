import 'package:custom_paint_progress_bar/themes.dart';
import 'package:custom_paint_progress_bar/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          CustomProgressTheme(
            lowerBoundColor: Colors.redAccent,
            upperBoundColor: Colors.greenAccent
          )
        ]
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: const CustomProgressBar(
              progress: 0.34,
            ),
          ),
        ),
      ),
    );
  }
}
