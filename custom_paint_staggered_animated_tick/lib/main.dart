import 'package:custom_paint_staggered_animated_tick/widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainAppScreen(),
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
          ),
          child: CustomTick(animationController: animationController),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.reset();
          animationController.forward();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10600));

    //animationController.repeat();
    animationController.value = 1;
  }
}
