import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:implicit_animation_animated_list/home/widgets.dart';
import 'package:implicit_animation_animated_list/home/main_app_scope.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController inputController;
  late final GlobalKey<AnimatedListState> listKey;

  @override
  Widget build(BuildContext context) {
    print("build _HomeScreenState");

    return Scaffold(
      body: Column(
        children: [
          DataInputWidget(inputController: inputController),
          Expanded(child: AnimListView(listKey: listKey)),
        ],
      ),
      floatingActionButton:
          FloatingButton(inputController: inputController, listKey: listKey),
    );
  }

  @override
  void initState() {
    super.initState();

    inputController = TextEditingController();

    inputController.addListener(_textChanged);

    listKey = GlobalKey<AnimatedListState>();
  }

  void _textChanged() {
    MainAppScope.controllerOf(context, listen: false)
        ?.validate(inputController.text);
  }

  @override
  void dispose() {
    inputController.removeListener(_textChanged);
    inputController.dispose();
    super.dispose();
  }
}
