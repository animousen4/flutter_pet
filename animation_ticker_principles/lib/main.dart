// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      home: MainAppView(),
    );
  }
}

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            child: RepaintBoundary(
              child: FadeTransition(
                opacity: animationController,
                child: Container(
                  color: Colors.red,
                  width: 300,
                  height: 100,
                ),
              ),
            ),
          ),
          Container(
            width: 300,
            height: 20,
            child: RepaintBoundary(
              child: LoadingLinePaint(
                animationController: animationController,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              animationController.reverse();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              animationController.forward();
            },
            child: const Icon(
              Icons.arrow_forward,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: getCurrentDuration);
  }

  Duration get getCurrentDuration => const Duration(milliseconds: 300);
}

class LoadingLinePaint extends StatelessWidget {
  const LoadingLinePaint({super.key, required this.animationController});

  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(
          animationController: animationController,
          baseColor: Colors.black,
          endRadius: 4),
    );
  }
}

class LinePainter extends CustomPainter {
  LinePainter(
      {required this.baseColor,
      required this.endRadius,
      required this.animationController})
      : super(repaint: animationController);

  final AnimationController animationController;

  final Color baseColor;

  final double endRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final value = animationController.value;

    final startOffset = Offset(0, size.height / 2);
    final endOffset = Offset(size.width * value, size.height / 2);

    if (value == 0) return;

    final linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final circlePaint = Paint()..color = baseColor;

    canvas.drawLine(startOffset, endOffset, linePaint);

    canvas.drawCircle(endOffset, endRadius, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
