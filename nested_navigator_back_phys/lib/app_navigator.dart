import 'dart:collection';

import 'package:flutter/material.dart';

typedef PageList = List<Page<Object?>>;
typedef PageNavigatorController = ValueNotifier<PageList>;

abstract class AppNavigatorController {
  void change(PageList Function(PageList pages) pages);
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key, required this.home, this.pageController});

  final PageNavigatorController? pageController;

  final Page<Object?> home;

  static AppNavigatorController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritAppRouter>()!.navigatorController;

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator>
    implements AppNavigatorController {
  late PageNavigatorController pageController;
  late HeroController heroController;
  @override
  Widget build(BuildContext context) {
    return _InheritAppRouter(
      navigatorController: this,
      // child: WillPopScope(
      //   onWillPop: () async {
      //     change((pages) => pages.getRange(0, pages.length - 1).toList());
      //     return true;
      //   },
      child: Navigator(
        observers: [
          heroController,
        ],
        pages: pageController.value,
        onPopPage: _onPopPage,
      ),
      //),
    );
  }

  bool _onPopPage(Route<Object?> route, Object? result) {
    if (!route.didPop(result)) return false;
    final pages = pageController.value;
    if (pages.length <= 1) return false;
    // You can implement custom logic here
    pageController.value =
        UnmodifiableListView<Page<Object?>>(pages.sublist(0, pages.length - 1));
    return true;
  }

  @override
  void initState() {
    super.initState();

    pageController = widget.pageController ?? PageNavigatorController([widget.home]);
    heroController = HeroController();

    pageController.addListener(_onPagesChanged);
  }

  @override
  void didUpdateWidget(covariant AppNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!identical(widget.pageController, pageController)) {
      pageController.removeListener(_onPagesChanged);
      pageController = widget.pageController ?? PageNavigatorController([widget.home]);

      // in case the controller provided upper doesn't contain any route
      if (pageController.value.isEmpty) {
        pageController.value = [widget.home];
      }

      pageController.addListener(_onPagesChanged);
    }
  }

  @override
  void dispose() {
    pageController.removeListener(_onPagesChanged);
    super.dispose();
  }

  void _onPagesChanged() => setState(() {});

  @override
  void change(PageList Function(PageList pages) pagesFunction) {
    final pages = pagesFunction(pageController.value);

    if (identical(pageController.value, pages)) {
      return;
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
    if (newPages.isEmpty) newPages.add(widget.home);
    pageController.value = UnmodifiableListView<Page<Object?>>(newPages);
  }
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