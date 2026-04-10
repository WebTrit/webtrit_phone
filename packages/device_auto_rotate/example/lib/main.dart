import 'dart:async';

import 'package:flutter/material.dart';

import 'package:device_auto_rotate/device_auto_rotate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isAutoRotateEnabled;
  StreamSubscription<bool>? _rotationSubscription;

  @override
  void initState() {
    super.initState();
    _initAutoRotateState();
    _startListening();
  }

  Future<void> _initAutoRotateState() async {
    final isEnabled = await DeviceAutoRotate.isEnabled;
    _updateRotationState(isEnabled);
  }

  void _startListening() {
    _rotationSubscription = DeviceAutoRotate.stream.listen(_updateRotationState);
  }

  void _updateRotationState(bool isEnabled) {
    if (!mounted) return;

    setState(() {
      _isAutoRotateEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);

    String statusText;
    IconData icon;
    Color color;

    if (_isAutoRotateEnabled == null) {
      statusText = 'Checking...';
      icon = Icons.help_outline;
      color = Colors.grey;
    } else if (_isAutoRotateEnabled!) {
      statusText = 'Auto Rotate: ON';
      icon = Icons.screen_rotation;
      color = Colors.green;
    } else {
      statusText = 'Auto Rotate: OFF';
      icon = Icons.screen_lock_portrait;
      color = Colors.red;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Device Auto Rotate Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: color),
              const SizedBox(height: 20),
              Text(statusText, style: textStyle),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Try toggling "Auto-rotate" in your quick settings panel to see updates.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rotationSubscription?.cancel();
    super.dispose();
  }
}
