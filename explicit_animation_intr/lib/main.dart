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
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final AnimationController playerController;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.all(12),
        child: ScaleTransition(
          scale: controller,
          child: Container(
            color: Colors.lightGreen,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (isPlaying) {
                    controller.stop();
                    playerController.forward();
                  } else {
                    controller.repeat(reverse: true);
                    playerController.reverse();
                  }
                });
              },
              child: AnimatedIcon(
                  icon: AnimatedIcons.pause_play, progress: playerController)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    playerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));

    controller.repeat(reverse: true);
  }

  bool get isPlaying => controller.isAnimating;
}
