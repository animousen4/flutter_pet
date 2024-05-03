import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implicit_animation_animated_list/home/main_app_scope.dart';

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

class FloatingButton extends StatelessWidget {
  const FloatingButton({
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
