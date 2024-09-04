import 'package:flutter/material.dart';
import 'package:layer_link_button/droppable_button.dart';

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
          child: DroppableButton<String>(
            selection: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('AAAAAA'),
            ),
            destinations: [
              DroppableDestination(
                value: "value",
                child: const Text("value"),
              )
            ],
            onDestinationSelected: (String value) {},
          ),
        ),
      ),
    );
  }
}
