import 'package:flutter/material.dart';

import 'package:inh_theme/theme_stf.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    print("App build");
    return const ThemeDataScope(
      child: MaterialContext(),
    );
  }
}

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    print("MaterialContext build");
    return MaterialApp(
      title: 'Inh theme demonstration',
      theme: ThemeDataScope.of(context).theme,
      home: const RootHomePage(),
    );
  }
}

class RootHomePage extends StatelessWidget {
  const RootHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("RootHomePage build");
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ThemeDataScope.of(context).reverseTheme();
          },
          child: const Text("Reverse theme")
        ),
      ),
    );
  }

}
