import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class _ParamsInherit extends InheritedWidget {
  final bool enabled;

  final ColorTween tween;

  final Duration duration;
  const _ParamsInherit(
      {super.key,
      required super.child,
      required this.enabled,
      required this.duration,
      required this.tween});

  @override
  bool updateShouldNotify(_ParamsInherit oldWidget) {
    return oldWidget.enabled != oldWidget.enabled || tween != oldWidget.tween;
  }

  static bool? enabledOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ParamsInherit>()?.enabled;

  static ColorTween? tweenOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_ParamsInherit>()?.tween;

  static Duration? durationOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_ParamsInherit>()?.duration;
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

abstract interface class MainAppController {
  void play();
}

class _MainAppState extends State<MainApp> implements MainAppController {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _ParamsInherit(
            duration: const Duration(milliseconds: 1300),
            enabled: enabled,
            tween: ColorTween(begin: Colors.white, end: Colors.greenAccent),
            child: const TweenPractise()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            play();
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }

  @override
  void play() {
    setState(() {
      enabled = !enabled;
    });
  }
}

class TweenPractise extends StatelessWidget {
  const TweenPractise({super.key});

  @override
  Widget build(BuildContext context) {
    final bool enabled = _ParamsInherit.enabledOf(context) ?? true;
    final ColorTween tween = _ParamsInherit.tweenOf(context)!;
    final Duration duration = _ParamsInherit.durationOf(context)!;

    print("1");
    final reverseTween = ReverseTween(tween);
    return TweenAnimationBuilder<Color?>(
        curve: Curves.decelerate,
        tween: enabled ? tween : reverseTween,
        duration: duration,
        builder: ((context, value, child) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(value!, BlendMode.modulate),
            child: const SizedBox.square(
              dimension: 200,
              child: FlutterLogo(),
            ),
          );
        }));
  }
}
