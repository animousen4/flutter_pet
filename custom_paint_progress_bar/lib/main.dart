import 'package:custom_paint_progress_bar/themes.dart';
import 'package:custom_paint_progress_bar/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(extensions: [
        CustomProgressTheme(
            lowerBoundColor: Colors.redAccent,
            upperBoundColor: Colors.greenAccent,
            reverseProgressColor: Colors.grey.shade700,
            backgroundColor: Colors.black87)
      ]),
      home: Scaffold(body: AppView()),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with TickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 150,
          height: 150,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => CustomProgressBar(
              progress: animationController.value,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  animationController.forward();
                },
                icon: Icon(Icons.play_arrow),
                label: Text("Play")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  animationController.reverse();
                },
                icon: Icon(Icons.restart_alt),
                label: Text("Reverse")),
            const SizedBox(
              height: 20,
            ),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1400));
  }
}
