// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/foundation.dart';
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

class AppRouter extends StatefulWidget {
  const AppRouter({
    super.key,
    required this.home,
  });

  final Page<Object?> home;

  static AppNavigatorController of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritAppRouter>()!
      .navigatorController;

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  late final AppNavigatorController appNavigatorController;
  late final HeroController heroController;

  @override
  Widget build(BuildContext context) {
    final parentButtonDispatcher =
        Router.maybeOf(context)?.backButtonDispatcher;

    final toUseButtonDispatcher = parentButtonDispatcher != null
        ? (ChildBackButtonDispatcher(parentButtonDispatcher)..takePriority())
        : RootBackButtonDispatcher();
    return _InheritAppRouter(
      navigatorController: appNavigatorController,
      child: Router(
        routerDelegate: _AppRouterDelegate(
          home: widget.home,
          appNavigatorController: appNavigatorController,
          heroController: heroController,
        ),
        backButtonDispatcher: toUseButtonDispatcher,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    appNavigatorController =
        AppNavigatorController(initialPages: [widget.home]);

    heroController = HeroController();
  }

  @override
  void dispose() {
    appNavigatorController.dispose();
    super.dispose();
  }
}

class _AppRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final AppNavigatorController appNavigatorController;
  final HeroController heroController;
  final Page<Object?> home;
  _AppRouterDelegate({
    required this.appNavigatorController,
    required this.heroController,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: appNavigatorController,
        builder: (context, value, child) {
          return Navigator(
            pages: value,
            onPopPage: _onPopPage,
            observers: [heroController],
          );
        });
  }

  bool _onPopPage(Route<Object?> route, Object? result) {
    if (!route.didPop(result)) return false;
    final pages = appNavigatorController.value;
    if (pages.length <= 1) return false;
    // You can implement custom logic here
    appNavigatorController.value =
        UnmodifiableListView<Page<Object?>>(pages.sublist(0, pages.length - 1));
    return true;
  }

  @override
  Future<bool> popRoute() {
    
    final popped = appNavigatorController
        .change((pages) => pages.getRange(0, pages.length - 1).toList());
    return SynchronousFuture(popped);
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {}
}
