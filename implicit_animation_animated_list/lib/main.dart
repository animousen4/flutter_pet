import 'package:flutter/material.dart';
import 'package:implicit_animation_animated_list/home/home_screen.dart';
import 'package:implicit_animation_animated_list/home/main_app_scope.dart';

void main() {
  runApp(const MaterialContext());
}

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainAppScope(child: MaterialApp(home: HomeScreen()));
  }
}


