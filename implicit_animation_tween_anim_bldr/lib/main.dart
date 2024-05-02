import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class ColorConfig {
  final Color begin;

  final Color end;

  const ColorConfig({required this.begin, required this.end});
}

class _ParamsInherit extends InheritedWidget {
  final bool enabled;

  final ColorConfig colorConfig;

  final Duration duration;
  const _ParamsInherit(
      {super.key,
      required super.child,
      required this.enabled,
      required this.duration,
      required this.colorConfig});

  @override
  bool updateShouldNotify(_ParamsInherit oldWidget) {
    return enabled != oldWidget.enabled;
  }

  static bool? enabledOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ParamsInherit>()?.enabled;

  static ColorConfig? tweenConfigOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_ParamsInherit>()?.colorConfig;
  }

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

  final colorConfig =
      const ColorConfig(begin: Colors.white, end: Colors.greenAccent);

  @override
  Widget build(BuildContext context) {
    print("_MainAppState build");
    return MaterialApp(
      home: Scaffold(
        body: _ParamsInherit(
            duration: const Duration(milliseconds: 1300),
            enabled: enabled,
            colorConfig: colorConfig,
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

      print(enabled);
    });
  }
}

class TweenPractise extends StatelessWidget {
  const TweenPractise({super.key});

  @override
  Widget build(BuildContext context) {
    final bool enabled = _ParamsInherit.enabledOf(context) ?? true;
    final Duration duration = _ParamsInherit.durationOf(context)!;
    final colorConfig = _ParamsInherit.tweenConfigOf(context)!;
    print("TweenPractise build");

    return TweenAnimationBuilder<Color?>(
        curve: Curves.decelerate,
        tween: enabled
            ? getForwardTween(colorConfig)
            : getReverseTween(colorConfig),
        duration: duration,
        builder: ((context, value, child) {
          //print("painting: $value");
          return ColorFiltered(
            colorFilter: ColorFilter.mode(value!, BlendMode.modulate),
            child: const SizedBox.square(
              dimension: 200,
              child: FlutterLogo(),
            ),
          );
        }));
  }

  ColorTween getForwardTween(ColorConfig colorConfig) =>
      ColorTween(begin: colorConfig.begin, end: colorConfig.end);

  ColorTween getReverseTween(ColorConfig colorConfig) =>
      ColorTween(begin: colorConfig.end, end: colorConfig.begin);
}
