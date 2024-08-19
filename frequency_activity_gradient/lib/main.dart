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
          child: FrequenciesWidget(
            frequencies: Frequencies(activity: [
              0.01,
              0.011,
              0.0121,
              0.0221,
              0.0220,
              0.0520,
              0.445,
            ]),
          ),
        ),
      ),
    );
  }
}
