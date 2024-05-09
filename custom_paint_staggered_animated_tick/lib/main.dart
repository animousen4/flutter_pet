import 'package:custom_paint_staggered_animated_tick/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  debugRepaintRainbowEnabled = true;
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
  bool repeat = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.red),
            // ),
            child: RepaintBoundary(
                child: CustomTick(animationController: animationController)),
          ),
          RepaintBoundary(
            child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Slider(
                      value: animationController.value,
                      onChanged: (value) {
                        animationController.value = value;
                      });
                }),
          ),
          CheckboxListTile(
              title: Text("Repeat"),
              value: repeat,
              onChanged: (value) => setState(() {
                    repeat = !repeat;
                    if (!repeat) {
                      animationController.forward();
                    }
                  }))
        ],
      ),
      floatingActionButton: RepaintBoundary(
        child: FloatingActionButton(
          onPressed: () {
            if (repeat) {
              animationController.repeat();
              return;
            }
            animationController.reset();
            animationController.forward();
          },
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    //animationController.repeat();
    //animationController.value = 1;
  }
}
