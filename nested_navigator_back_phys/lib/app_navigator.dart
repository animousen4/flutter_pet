import 'dart:collection';

import 'package:flutter/material.dart';

typedef PageList = List<Page<Object?>>;
typedef PageNavigatorValueNotifier = ValueNotifier<PageList>;

class AppNavigatorController extends PageNavigatorValueNotifier {
  bool change(PageList Function(PageList pages) pagesFunction) {
    final pages = pagesFunction(value);

    if (identical(value, pages)) {
      return false;
    }

    final set = <LocalKey>{};
    final newPages = <Page<Object?>>[];
    for (var i = pages.length - 1; i >= 0; i--) {
      final page = pages[i];
      final key = page.key;
      if (set.contains(page.key) || key == null) continue;
      set.add(key);
      newPages.insert(0, page);
    }
    if (newPages.isNotEmpty) {
      value = UnmodifiableListView<Page<Object?>>(newPages);

      return true;
    }

    return false;
  }

  AppNavigatorController({required PageList initialPages})
      : super(initialPages);
}

class AppNavigator extends StatefulWidget {
  const AppNavigator(
      {super.key, required this.home, this.appNavigatorController});

  final AppNavigatorController? appNavigatorController;

  final Page<Object?> home;

  static AppNavigatorController of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritAppRouter>()!
      .navigatorController;

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  late AppNavigatorController appNavigatorController;
  late HeroController heroController;
  @override
  Widget build(BuildContext context) {
    return _InheritAppRouter(
      navigatorController: appNavigatorController,

      child: Navigator(
        observers: [
          heroController,
        ],
        pages: appNavigatorController.value,
        onPopPage: _onPopPage,
      ),
      //),
    );
  }

  bool _onPopPage(Route<Object?> route, Object? result) {
    appNavigatorController
        .change((pages) => pages.getRange(0, pages.length - 1).toList());
    return false;
  }

  @override
  void initState() {
    super.initState();

    appNavigatorController = widget.appNavigatorController ??
        AppNavigatorController(initialPages: [widget.home]);
    heroController = HeroController();

    appNavigatorController.addListener(_onPagesChanged);
  }

  @override
  void didUpdateWidget(covariant AppNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!identical(widget.appNavigatorController, appNavigatorController) &&
        widget.appNavigatorController != null) {
      appNavigatorController.removeListener(_onPagesChanged);

      appNavigatorController = widget.appNavigatorController ??
          AppNavigatorController(initialPages: [widget.home]);

      // in case the controller provided upper doesn't contain any route
      if (appNavigatorController.value.isEmpty) {
        appNavigatorController.value = [widget.home];
      }

      appNavigatorController.addListener(_onPagesChanged);
    }
  }

  @override
  void dispose() {
    appNavigatorController.removeListener(_onPagesChanged);
    if (widget.appNavigatorController == null) {
      appNavigatorController.dispose();
    }
    super.dispose();
  }

  void _onPagesChanged() => setState(() {});

  // @override
  // bool change(PageList Function(PageList pages) pagesFunction) {
  //   final pages = pagesFunction(appNavigatorController.value);

  //   if (identical(appNavigatorController.value, pages)) {
  //     return false;
  //   }

  //   final set = <LocalKey>{};
  //   final newPages = <Page<Object?>>[];
  //   for (var i = pages.length - 1; i >= 0; i--) {
  //     final page = pages[i];
  //     final key = page.key;
  //     if (set.contains(page.key) || key == null) continue;
  //     set.add(key);
  //     newPages.insert(0, page);
  //   }
  //   if (newPages.isEmpty) newPages.add(widget.home);
  //   appNavigatorController.value = UnmodifiableListView<Page<Object?>>(newPages);

  //   return true;
  // }
}

class _InheritAppRouter extends InheritedWidget {
  const _InheritAppRouter({
    required this.navigatorController,
    required super.child,
  });

  final AppNavigatorController navigatorController;

  @override
  bool updateShouldNotify(covariant _InheritAppRouter oldWidget) =>
      !identical(navigatorController, oldWidget.navigatorController);
}
