import 'package:flutter/material.dart';
import 'package:nested_navigator_back_phys/app_navigator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final PageNavigatorController appNavigatorController = ValueNotifier(
      [const MaterialPage(key: ValueKey("screen_one"), child: _ScreenOne())]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          appNavigatorController.value = appNavigatorController.value
              .getRange(0, appNavigatorController.value.length - 1)
              .toList();
          return false;
        },
        child: AppNavigator(
          pageController: appNavigatorController,
          home: const MaterialPage(
              key: ValueKey("screen_one"), child: _ScreenOne()),
        ),
      ),
    );
  }
}

class _ScreenOne extends StatelessWidget {
  const _ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen one"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              AppNavigator.of(context).change((pages) => [
                    ...pages,
                    const MaterialPage(
                        key: ValueKey("screen_two"), child: _ScreenTwo())
                  ]);
            },
            child: const Text("Second screen")),
      ),
    );
  }
}

class _ScreenTwo extends StatelessWidget {
  const _ScreenTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen SECOND!!!!!!!"),
      ),
    );
  }
}
