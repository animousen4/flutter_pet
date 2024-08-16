import 'package:declarative_navigation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SomeScreen extends StatelessWidget {
  const SomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class UseScreen extends StatelessWidget {
  const UseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNavigator(home: MaterialPage(child: SomeScreen()));
  }
}
