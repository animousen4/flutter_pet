// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialContext());
}

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainAppScope(child: MaterialApp(home: HomeScreen()));
  }
}

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

  @override
  bool operator ==(covariant MainAppViewModelState other) {
    return listEquals(other.elements, elements) &&
        listEquals(other.errors, errors);
  }

  @override
  int get hashCode => elements.hashCode ^ errors.hashCode;
}

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
          _FloatingButton(inputController: inputController, listKey: listKey),
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

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({
    super.key,
    required this.inputController,
    required this.listKey,
  });

  final TextEditingController inputController;
  final GlobalKey<AnimatedListState> listKey;

  @override
  Widget build(BuildContext context) {
    final elementsController = MainAppScope.controllerOf(context)!;
    final MainAppViewModelState state = MainAppScope.stateOf(context)!;

    return FloatingActionButton(
      onPressed: state.isValid
          ? () {
              elementsController.addElement(inputController.text);
              listKey.currentState?.insertItem(state.elements.length - 1);
              inputController.clear();
            }
          : null,
      child: const Icon(Icons.add),
    );
  }
}

class AnimListView extends StatelessWidget {
  const AnimListView({
    super.key,
    required this.listKey,
  });

  final GlobalKey<AnimatedListState> listKey;

  @override
  Widget build(BuildContext context) {
    final elementsController = MainAppScope.controllerOf(context)!;
    final state = MainAppScope.stateOf(context)!;
    return AnimatedList(
      key: listKey,
      itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: InkWell(
              onTap: () {
                final element = elementsController.removeElement(index);
                listKey.currentState?.removeItem(
                    index,
                    (context, animation) => AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) => SizeTransition(
                            sizeFactor: animation,
                            child: SlideTransition(
                              position: animation.drive(Tween(
                                  begin: const Offset(1.0, 0.0),
                                  end: const Offset(0.0, 0.0))),
                              child: FadeTransition(
                                  opacity: animation, child: child),
                            ),
                          ),
                          child: ListElement(element: element),
                        ));
              },
              child: ListElement(element: state.elements[index]))),
      initialItemCount: state.elements.length,
    );
  }
}

class DataInputWidget extends StatelessWidget {
  const DataInputWidget({
    super.key,
    required this.inputController,
  });

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    final mainAppState = MainAppScope.stateOf(context)!;
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
          error: mainAppState.errors.isEmpty
              ? null
              : Text(mainAppState.errors.first.error)),
    );
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
