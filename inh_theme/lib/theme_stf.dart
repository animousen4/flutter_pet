import 'package:flutter/material.dart';
import 'package:inh_theme/build_context_extension.dart';

enum ThemeAspect {
  light,

  dark
}

abstract interface class ThemeDataController {
  ThemeData get theme;

  void setThemeByAspect(ThemeAspect aspect);

  void reverseTheme();
}

class ThemeDataScope extends StatefulWidget {
  const ThemeDataScope({super.key, required this.child});

  final Widget child;

  @override
  State<ThemeDataScope> createState() => _ThemeDataScopeState();

  static ThemeDataController of(BuildContext context) =>
      context.inheritOf<_ThemeDataInh>(listen: true)!.themeDataController;
}

class _ThemeDataScopeState extends State<ThemeDataScope>
    implements ThemeDataController {
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    print("_ThemeDataScopeState build");
    return _ThemeDataInh(
      themeData: themeData,
      themeDataController: this,
      child: widget.child,
    );
  }

  @override
  void setThemeByAspect(ThemeAspect aspect) {
    setState(() {
      switch (aspect) {
        case ThemeAspect.dark:
          themeData = ThemeData(brightness: Brightness.dark);
          break;

        case ThemeAspect.light:
          themeData = ThemeData(brightness: Brightness.light);
          break;

        default:
          throw UnimplementedError();
      }
    });
  }

  @override
  ThemeData get theme => themeData;

  @override
  void initState() {
    print("ThemeDataScope initState()");
    themeData = ThemeData.dark();
    super.initState();
  }

  @override
  void reverseTheme() {
    print("Reversing theme");
    setState(() {
      themeData = themeData.brightness == Brightness.dark
          ? ThemeData.light()
          : ThemeData.dark();
    });
  }
}

class _ThemeDataInh extends InheritedWidget {
  const _ThemeDataInh(
      {required super.child,
      required this.themeData,
      required this.themeDataController});

  final ThemeData themeData;

  final ThemeDataController themeDataController;
  @override
  bool updateShouldNotify(covariant _ThemeDataInh oldWidget) {
    var shouldUpd = themeData != oldWidget.themeData;
    print("_ThemeDataInh updateShouldNotify = $shouldUpd");
    return shouldUpd;
  }
}
