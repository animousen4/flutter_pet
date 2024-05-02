import 'package:flutter/material.dart';
import 'package:implicit_animation_animated_list/home/widgets.dart';

abstract interface class ElementsController {
  void validate(String text);
  void addElement(String element);
  String removeElement(int index);
}

class MainAppScope extends StatefulWidget {
  const MainAppScope({super.key, required this.child});

  final Widget child;

  @override
  State<MainAppScope> createState() => _MainAppScopeState();

  static MainAppViewModelState? stateOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritMainApp>()?.state;

  static ElementsController? controllerOf(BuildContext context,
          {bool listen = true}) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_InheritMainApp>()
              ?.elementsController
          : context
              .getInheritedWidgetOfExactType<_InheritMainApp>()
              ?.elementsController;
}

class _MainAppScopeState extends State<MainAppScope>
    implements ElementsController {
  MainAppViewModelState state = MainAppViewModelState.empty([]);

  @override
  Widget build(BuildContext context) {
    print("build _MainAppScopeState");
    return _InheritMainApp(
      state: state,
      elementsController: this,
      child: widget.child,
    );
  }

  @override
  void addElement(String element) {
    setState(() {
      if (state.isValid) {
        state.elements.add(element);
      }
    });
  }

  @override
  String removeElement(int index) {
    setState(() {});
    return state.elements.removeAt(index);
  }

  @override
  void validate(String text) {
    final errors = <ValidationError>[];

    if (text.isEmpty) {
      errors.add(ValidationError(error: "This field shouldn't be empty"));
    }

    state = state.copyWith(errors: errors);

    setState(() {});
  }
}

class _InheritMainApp extends InheritedWidget {
  final MainAppViewModelState state;
  final ElementsController elementsController;

  const _InheritMainApp(
      {required super.child,
      required this.state,
      required this.elementsController});

  @override
  bool updateShouldNotify(_InheritMainApp oldWidget) {
    final shouldUpdate = state != oldWidget.state;
    return shouldUpdate;
  }
}
