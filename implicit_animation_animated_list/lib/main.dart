// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

abstract interface class ElementsController {
  void addElement(String element);
  void removeElement(int index);
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
    return state != oldWidget.state;
  }

  static MainAppViewModelState? stateOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritMainApp>()?.state;
}

class ValidationError {
  final String error;

  ValidationError({required this.error});
}

class MainAppViewModelState {
  final List<String> elements;

  final List<ValidationError> errors;

  const MainAppViewModelState({required this.elements, required this.errors});

  bool get isValid => errors.isEmpty;

  factory MainAppViewModelState.empty(List<ValidationError> errors) =>
      MainAppViewModelState(elements: [], errors: errors);

  MainAppViewModelState copyWith({
    List<String>? elements,
    List<ValidationError>? errors,
  }) {
    return MainAppViewModelState(
      elements: elements ?? this.elements,
      errors: errors ?? this.errors,
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> implements ElementsController {
  late final TextEditingController inputController;
  late final GlobalKey<AnimatedListState> listKey;
  late MainAppViewModelState mainAppState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: inputController,
              decoration: InputDecoration(
                  error: mainAppState.errors.isEmpty
                      ? null
                      : Text(mainAppState.errors.first.error)),
            ),
            Expanded(
                child: AnimatedList(
              key: listKey,
              itemBuilder: (context, index, animation) => SizeTransition(
                  sizeFactor: animation,
                  child: InkWell(
                      onTap: () => removeElement(index),
                      child:
                          ListElement(element: mainAppState.elements[index]))),
              initialItemCount: mainAppState.elements.length,
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: mainAppState.isValid
              ? () {
                  addElement(inputController.text);
                }
              : null,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    inputController = TextEditingController();

    inputController.addListener(_textChanged);

    mainAppState = MainAppViewModelState.empty([]);

    listKey = GlobalKey<AnimatedListState>();
  }

  void _textChanged() {
    setState(() {
      final errors = _validateText(inputController.text);
      mainAppState = mainAppState.copyWith(errors: errors);
    });
  }

  List<ValidationError> _validateText(String text) {
    final List<ValidationError> errors = [];

    if (text.isEmpty) {
      final error = ValidationError(error: "Field shouldn't be empty");
      errors.add(error);
    }

    return errors;
  }

  @override
  void addElement(String element) {
    if (mainAppState.isValid) {
      mainAppState.elements.add(element);
      final index = mainAppState.elements.length - 1;
      listKey.currentState
          ?.insertItem(index, duration: const Duration(milliseconds: 60));
    }
  }

  @override
  void removeElement(int index) {
    final element = mainAppState.elements.removeAt(index);

    listKey.currentState?.removeItem(
        index,
        (context, animation) => AnimatedBuilder(
              animation: animation,
              builder: (context, child) => SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(opacity: animation, child: child)),
              child: ListElement(
                element: element,
              ),
            ),
        duration: const Duration(milliseconds: 60));
  }

  @override
  void dispose() {
    inputController.removeListener(_textChanged);
    super.dispose();
  }
}

class ListElement extends StatelessWidget {
  const ListElement({
    super.key,
    required this.element,
  });

  final String element;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(element),
    );
  }
}
