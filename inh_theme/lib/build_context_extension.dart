import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {

  // get inh widget or subscribe
  T? inheritOf<T extends InheritedWidget>({bool listen = true}) => listen 
     ? dependOnInheritedWidgetOfExactType<T>()
     : getInheritedWidgetOfExactType<T>();

  // subscribe on changes in model
  T? inheritFrom<A extends Object, T extends InheritedModel>({A? aspect}) =>
    InheritedModel.inheritFrom(this, aspect: aspect);

}