import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

abstract interface class CameraScopeController {
  void rotateCamera();
}

class CameraScope extends StatefulWidget {
  const CameraScope({super.key, required this.cameras, required this.child});

  final Widget child;

  final List<CameraDescription> cameras;

  static CameraController cameraDescriptionOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritCameraScope>()!
      .currentCameraController;

  static CameraScopeController controllerOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritCameraScope>()!
      .cameraController;

  @override
  State<CameraScope> createState() => _CameraScopeState();
}

class _CameraScopeState extends State<CameraScope>
    implements CameraScopeController {
  int activeCameraIndex = 0;

  late final List<CameraController> cameraControllers;

  @override
  Widget build(BuildContext context) {
    return _InheritCameraScope(
        cameraController: this,
        currentCameraController: cameraControllers[activeCameraIndex],
        child: widget.child);
  }

  @override
  void rotateCamera() {
    setState(() {
      if (activeCameraIndex == 0) {
        activeCameraIndex++;
      } else {
        activeCameraIndex = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    cameraControllers = widget.cameras
        .map((description) =>
            CameraController(description, ResolutionPreset.high))
        .toList();
    
    for (final controller in cameraControllers) {
      controller.initialize();
    }
  }

  @override
  void dispose() {
    for (final controller in cameraControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _InheritCameraScope extends InheritedWidget {
  final CameraController currentCameraController;

  final CameraScopeController cameraController;

  const _InheritCameraScope(
      {required this.currentCameraController,
      required this.cameraController,
      required super.child});

  @override
  bool updateShouldNotify(_InheritCameraScope oldWidget) {
    throw UnimplementedError();
  }
}
