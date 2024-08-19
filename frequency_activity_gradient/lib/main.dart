import 'package:flutter/material.dart';

import 'freq.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FrequenciesCircle(
            frequencies: Frequencies(activity: [
              0.004,
              0.0043,
              0.015,
              0.019,
              0.2,
              0.5,
              0.7,
            ]),
          ),
        ),
      ),
    );
  }
}
