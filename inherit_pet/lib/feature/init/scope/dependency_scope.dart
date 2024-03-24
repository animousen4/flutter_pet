import 'package:flutter/material.dart';
import 'package:inherit_pet/feature/init/dependencies/dependencies.dart';

class DependencyScope extends StatelessWidget {

  final Dependencies dependencies;

  final Widget child;

  const DependencyScope({super.key, required this.dependencies, required this.child});

  static Dependencies dependenciesOf(BuildContext context) => 
    context.getInheritedWidgetOfExactType<_InheritedDependency>()!.dependencies;

  @override
  Widget build(BuildContext context) {
    return _InheritedDependency(dependencies: dependencies, child: child);
  }
}

class _InheritedDependency extends InheritedWidget {
  
  const _InheritedDependency({required this.dependencies, required super.child});

  final Dependencies dependencies;

  @override
  bool updateShouldNotify(covariant _InheritedDependency oldWidget) {
    // dependencies cant be changed
    return false;
  }
}