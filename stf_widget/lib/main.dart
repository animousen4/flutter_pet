import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stf widget dive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark, seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SomePage(),
    );
  }
}

class RedBox extends StatefulWidget {
  const RedBox({super.key});

  @override
  State<RedBox> createState() => _RedBoxState();

  static int valueOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_RedBoxInh>()!.value;
}

class _RedBoxState extends State<RedBox> {
  int redCounter = 0;

  @override
  Widget build(BuildContext context) {
    print("Red build");
    return _RedBoxInh(
      value: redCounter,
      child: Container(
        color: Colors.red,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        redCounter++;
                      });
                    },
                    child: Text("$redCounter")),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Expanded(child: GreenBox()),
                    Expanded(
                        child: redCounter % 2 == 0
                            ? const BlueBox()
                            : const PinkBox())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("Red didChangeDependencies");
  }

  @override
  void initState() {
    super.initState();

    print("Red initState");
  }

  @override
  void deactivate() {
    print("Red deactivation");
    super.deactivate();
  }

  @override
  void dispose() {
    print("Red dispose");
    super.dispose();
  }
}

class _RedBoxInh extends InheritedWidget {
  final int value;

  const _RedBoxInh({required super.child, required this.value});

  @override
  bool updateShouldNotify(covariant _RedBoxInh oldWidget) {
    return oldWidget.value != value;
  }
}

class GreenBox extends StatefulWidget {
  const GreenBox({super.key});

  @override
  State<GreenBox> createState() => _GreenBoxState();
}

class _GreenBoxState extends State<GreenBox> {
  int greenCounter = 0;
  int redValue = 0;
  @override
  Widget build(BuildContext context) {
    print("Green build");
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.green,
      child: Column(
        children: [
          Expanded(child: Center(child: Text("$redValue"))),
          Expanded(
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      greenCounter++;
                    });
                  },
                  child: Text("$greenCounter")),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // subscribing on the inherited of RedBox
    redValue = RedBox.valueOf(context);

    print("Green didChangeDependencies");
  }

  @override
  void initState() {
    super.initState();

    print("Green initState");
  }

  @override
  void deactivate() {
    print("Green deactivation");
    super.deactivate();
  }

  @override
  void dispose() {
    print("Green dispose");
    super.dispose();
  }
}

class BlueBox extends StatefulWidget {
  const BlueBox({super.key});

  @override
  State<BlueBox> createState() => _BlueBoxState();
}

class _BlueBoxState extends State<BlueBox> {
  int blueCounter = 0;

  @override
  Widget build(BuildContext context) {
    print("Blue build");
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.blue,
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                blueCounter++;
              });
            },
            child: Text("$blueCounter")),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("Blue didChangeDependencies");
  }

  @override
  void initState() {
    super.initState();

    print("Blue initState");
  }

  @override
  void deactivate() {
    print("Blue deactivation");
    super.deactivate();
  }

  @override
  void dispose() {
    print("Blue dispose");
    super.dispose();
  }
}

class PinkBox extends StatefulWidget {
  const PinkBox({super.key});

  @override
  State<PinkBox> createState() => _PinkBoxState();
}

class _PinkBoxState extends State<PinkBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }
}

class SomePage extends StatelessWidget {
  const SomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RedBox(),
    );
  }
}
