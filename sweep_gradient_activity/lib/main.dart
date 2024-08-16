import 'package:flutter/material.dart';

import 'gradient_activity.dart';

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
          child: SizedBox.square(
              dimension: 250,
              child: ActivityWidget(
                periods: [
                  ActivityPeriod(activity: 0.3, start: 0, end: 0.10),
                  ActivityPeriod(activity: 0.9, start: 0.20, end: 0.55),
                  ActivityPeriod(activity: 0.2, start: 0.78, end: 1),
                  //ActivityPeriod(activity: 0.1, start: 0.15, end: 1),
                  //ActivityPeriod(activity: 1, start: 0.5, end: 1),
                  //ActivityPeriod(activity: 0.2, start: 0.33, end: 0.5)
                ],
              )),
        ),
      ),
    );
  }
}
