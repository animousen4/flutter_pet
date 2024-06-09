import 'package:barcode_scanner_pet/widget/camera_scope.dart';
import 'package:barcode_scanner_pet/widget/camera_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScope(
        cameras: _cameras,
        child: const Scaffold(
          body: Center(
            child: CameraWidget(),
          ),
        ),
      ),
    );
  }
}
