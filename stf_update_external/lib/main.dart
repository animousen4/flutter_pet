import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("MyApp build");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

abstract interface class HomePageController {
  void update();
}

class _HomePageInherit extends InheritedWidget {
  final HomePageController controller;
  final int num;

  const _HomePageInherit(
      {required super.child, required this.controller, required this.num});

  @override
  bool updateShouldNotify(covariant _HomePageInherit oldWidget) {
    return oldWidget.num != num;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomePageController {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    print("_HomePageState build");
    return Scaffold(
      body: Column(
        children: [
          Text("Number: $num"),
          _HomePageInherit(
            controller: this,
            num: num,
            // if we don't have const here, the build will be called in SomeWidgetInTree
            // externally
            child: const StfWidget(),
          ),
          ElevatedButton(
              onPressed: () {
                update();
              },
              child: const Text("update"))
        ],
      ),
    );
  }

  @override
  void initState() {
    print("_HomePageState initState()");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_HomePageState didChangeDependencies()");
  }

  @override
  void update() {
    setState(() {
      num++;
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    print("_HomePageState deactivate()");
  }

  @override
  void dispose() {
    super.dispose();
    print("_HomePageState dispose()");
  }
}

class StfWidget extends StatefulWidget {
  const StfWidget({super.key});

  @override
  State<StfWidget> createState() => _StfWidgetState();
}

class _StfWidgetState extends State<StfWidget> {

  var num = 0;
  @override
  Widget build(BuildContext context) {
    // subscribing to state of inherited
    ;
    print("_StfWidgetState build");
    return Text("_StfWidgetState: $num");
  }


  @override
  void initState() {
    print("_StfWidgetState initState()");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_StfWidgetState didChangeDependencies()");

    num =
        context.dependOnInheritedWidgetOfExactType<_HomePageInherit>()!.num;
  }

  @override
  void didUpdateWidget(covariant StfWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_StfWidgetState didUpdateWidget()");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("_StfWidgetState deactivate()");
  }

  @override
  void dispose() {
    super.dispose();
    print("_StfWidgetState dispose()");
  }
}
