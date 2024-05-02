import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class TweenProp<T> {
  final T enabled;
  final T disabled;

  const TweenProp({required this.enabled, required this.disabled});
}

class AnimationConfig {
  final TweenProp<double> opacity;

  const AnimationConfig({required this.opacity});
}

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      width: 100,
      height: 100,
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: HomeScreen(
      animationConfig: AnimationConfig(
        opacity: TweenProp(enabled: 1.0, disabled: 0.0),
      ),
      duration: Duration(
        milliseconds: 300,
      ),
    ));
  }
}

class SizedBox30 extends StatelessWidget {
  const SizedBox30({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.duration, required this.animationConfig});

  final Duration duration;

  final AnimationConfig animationConfig;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool enabled = true;

  double rotateDegress = 0.0;

  @override
  Widget build(BuildContext context) {
    final opacityConfig = widget.animationConfig.opacity;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
                opacity:
                    enabled ? opacityConfig.enabled : opacityConfig.disabled,
                duration: widget.duration,
                child: const ColoredContainer()),
            const SizedBox30(),
            AnimatedRotation(
              turns: rotateDegress,
              duration: widget.duration,
              child: const ColoredContainer(),
            ),
            const SizedBox30(),
            AnimatedContainer(
                duration: widget.duration,
                color: enabled ? Colors.redAccent : Colors.blue,
                child: const SizedBox.square(
                  dimension: 100,
                )),
            const SizedBox30(),
            AnimatedSize(
              duration: widget.duration,
              curve: Curves.bounceInOut,
              child: FlutterLogo(
                size: enabled ? 100 : 30,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            enabled = !enabled;
            rotateDegress += 15 / 360;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
