import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  late final AnimationController redController;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: GreenBoxScreen(),
        ),
        Expanded(child: RedBoxScreen()),
        Expanded(child: LogoBoxScreen())
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class RedBoxScreen extends StatefulWidget {
  const RedBoxScreen({super.key});

  @override
  State<RedBoxScreen> createState() => _RedBoxScreenState();
}

class _RedBoxScreenState extends State<RedBoxScreen>
    with TickerProviderStateMixin {
  late final AnimationController redController;
  late final AnimationController playerController;

  @override
  Widget build(BuildContext context) {
    print("RedBox build");
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if (redController.isAnimating) {
                redController.stop();
                playerController.reverse();
              } else {
                await redController.animateTo(0.7);
                await redController.fling(velocity: -2);
                await playerController.reverse();
              }
            },
            child: AnimatedIcon(
                icon: AnimatedIcons.play_pause, progress: playerController),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(70),
        child: Container(
          color: Colors.white24,
          child: SizeTransition(
            sizeFactor: redController,
            child: Container(
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    redController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    playerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));
  }
}

class GreenBoxScreen extends StatefulWidget {
  const GreenBoxScreen({super.key});

  @override
  State<GreenBoxScreen> createState() => _GreenBoxScreenState();
}

class _GreenBoxScreenState extends State<GreenBoxScreen>
    with TickerProviderStateMixin {
  late final AnimationController greenController;
  late final AnimationController playerController;
  @override
  Widget build(BuildContext context) {
    print("GreenBox build");
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        padding: EdgeInsets.all(80),
        child: FadeTransition(
          opacity: greenController,
          child: ScaleTransition(
            scale: greenController,
            child: Container(
              color: Colors.lightGreen,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (greenController.isAnimating) {
              playerController.reverse();

              greenController.stop();
            } else {
              playerController.forward();

              greenController.repeat(reverse: true);
            }
          },
          child: AnimatedIcon(
              icon: AnimatedIcons.play_pause, progress: playerController)),
    );
  }

  @override
  void initState() {
    super.initState();

    greenController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    playerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));
  }
}

// Using transform
class LogoBoxScreen extends StatefulWidget {
  const LogoBoxScreen({super.key});

  @override
  State<LogoBoxScreen> createState() => _LogoBoxScreenState();
}

class _LogoBoxScreenState extends State<LogoBoxScreen>
    with TickerProviderStateMixin {
  late final AnimationController logoController;

  late final AnimationController playerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (logoController.isAnimating) {
            playerController.reverse();
            logoController.stop();
          } else {
            playerController.forward();
            await logoController.forward();
            playerController.reverse();
            logoController.value = 0;
          }
        },
        child: AnimatedIcon(
            icon: AnimatedIcons.play_pause, progress: playerController),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: logoController,
          builder: (context, child) {
            return Transform.rotate(
              angle: logoController.value * 2 * pi,
              child: child,
            );
          },
          child: const SizedBox(
            width: 100,
            height: 100,
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    playerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));
  }
}
