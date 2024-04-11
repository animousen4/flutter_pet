import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeWidget());
  }
}

class ColoredBox extends StatefulWidget {
  const ColoredBox({super.key, required this.initColor});

  final Color initColor;

  @override
  State<ColoredBox> createState() => _ColoredBoxState();
}

class _ColoredBoxState extends State<ColoredBox> {
  late Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: Container(color: color),
    );
  }

  @override
  void initState() {
    color = widget.initColor;
    super.initState();
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

abstract interface class HomeController {
  void swap();
}

class SwapperLayout extends StatelessWidget {
  const SwapperLayout({super.key, required this.boxes});

  final List<Widget> boxes;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [...boxes],
    );
  }
}

class SomeParam {
  final int id;

  const SomeParam(this.id);
  
  @override
  bool operator==(Object other) {
    return other is SomeParam && other.runtimeType == runtimeType && id == other.id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  
  
}

class _HomeWidgetState extends State<HomeWidget> implements HomeController {
  /// using keys in order to show flutter the difference between this two same elements (by class)
  /// so in element treen states also will be swapped

  List<Widget> boxesUniqueKey = [
    ColoredBox(initColor: Colors.redAccent, key: UniqueKey()),
    ColoredBox(
      initColor: Colors.blueAccent,
      key: UniqueKey(),
    )
  ];

  List<Widget> boxesValueKey = [
    const ColoredBox(initColor: Colors.redAccent, key: ValueKey(1111)),
    const ColoredBox(
      initColor: Colors.blueAccent,
      key: ValueKey(2222),
    )
  ];

  List<Widget> boxesObjectKey = [
    // We need to override operator== and hashcode, to differ keys, else they will work like UniqueKey
    const ColoredBox(initColor: Colors.redAccent, key: ObjectKey(SomeParam(1))),
    const ColoredBox(
      initColor: Colors.blueAccent,
      key: ObjectKey(SomeParam(2)),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(child: SwapperLayout(boxes: boxesUniqueKey)),
        Expanded(child: SwapperLayout(boxes: boxesValueKey)),
        Expanded(child: SwapperLayout(boxes: boxesObjectKey)),
        ElevatedButton(
            onPressed: () {
              swap();
            },
            child: const Text("Swap"))
      ],
    ));
  }

  @override
  void swap() {
    setState(() {
      boxesUniqueKey = _swapTwo(boxesUniqueKey);
      boxesValueKey = _swapTwo(boxesValueKey);
      boxesObjectKey = _swapTwo(boxesObjectKey);
    });
  }

  List<T> _swapTwo<T>(List<T> elements) {
    var first = elements[0];
    elements.removeAt(0);
    elements.add(first);

    return elements;
  }
}
