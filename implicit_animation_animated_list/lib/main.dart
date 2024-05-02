import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

abstract interface class MainAppController {
  void addElement(String element);
}

class _InheritMainApp extends InheritedWidget {
  final MainAppViewModelState state;
  final MainAppController controller;

  const _InheritMainApp(
      {required super.child, required this.state, required this.controller});

  @override
  bool updateShouldNotify(_InheritMainApp oldWidget) {
    return state != oldWidget.state;
  }
}

class MainAppViewModelState {
  final List<String> elements;

  const MainAppViewModelState({required this.elements});

  factory MainAppViewModelState.empty() =>
      const MainAppViewModelState(elements: []);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> implements MainAppController {
  final inputController = TextEditingController();

  MainAppViewModelState mainAppState = MainAppViewModelState.empty();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          TextFormField(
            controller: inputController,
          ),
          _InheritMainApp(controller: this, state: mainAppState, child: const AnimListView()),
        ],
      )),
    );
  }

  @override
  void addElement(String element) {
    
  }
}

class AnimListView extends StatefulWidget {
  const AnimListView({super.key});

  @override
  State<AnimListView> createState() => _AnimListViewState();
}

class _AnimListViewState extends State<AnimListView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
