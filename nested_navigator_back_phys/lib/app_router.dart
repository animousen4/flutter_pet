// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:nested_navigator_back_phys/app_navigator.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({
    super.key,
    required this.home,
  });

  final Page<Object?> home;
  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  late final AppNavigatorController appNavigatorController;
  @override
  Widget build(BuildContext context) {
    final parentButtonDispatcher =
        Router.maybeOf(context)?.backButtonDispatcher;

    final toUseButtonDispatcher = parentButtonDispatcher != null
        ? (ChildBackButtonDispatcher(parentButtonDispatcher)..takePriority())
        : RootBackButtonDispatcher();
    return Router(
      routerDelegate: _AppRouterDelegate(
          home: widget.home, appNavigatorController: appNavigatorController),
      backButtonDispatcher: toUseButtonDispatcher,
    );
  }

  @override
  void initState() {
    super.initState();

    appNavigatorController =
        AppNavigatorController(initialPages: [widget.home]);
  }

  @override
  void dispose() {
    appNavigatorController.dispose();
    super.dispose();
  }
}

class _AppRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final AppNavigatorController appNavigatorController;

  final Page<Object?> home;
  _AppRouterDelegate({
    required this.appNavigatorController,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return AppNavigator(home: home);
  }

  @override
  Future<bool> popRoute() {

    return SynchronousFuture(true);
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {}
}
