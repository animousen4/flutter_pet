import 'package:flutter/material.dart';
import 'package:nested_navigator_back_phys/app_navigator.dart';
import 'package:nested_navigator_back_phys/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppRouter(
        home: MaterialPage(
          key: ValueKey("app_root_nav"),
          child: AppRouter(
            home: MaterialPage(
              key: ValueKey("screen_one"),
              child: _ScreenOne(),
            ),
          ),
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
            AppRouter.of(context).change(
              (pages) => [
                ...pages,
                const MaterialPage(
                  key: ValueKey("screen_two"),
                  child: _ScreenTwo(),
                )
              ],
            );
          },
          child: const Text("Second screen"),
        ),
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
        leading: const BackButton(),
        title: const Text("Screen SECOND!!!!!!!"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (context) => WillPopScope(
                        onWillPop: () async => true,
                        child: AlertDialog(
                          title: const Text("Alert"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final navigator = Navigator.of(context);

                                navigator.maybePop();
                              },
                              child: const Text("POP"),
                            )
                          ],
                        ),
                      ));
            },
            child: const Text("Show dialog")),
      ),
    );
  }
}
