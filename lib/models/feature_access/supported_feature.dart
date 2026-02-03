import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for supported features and global app behaviors.
class SupportedConfig extends Equatable {
  const SupportedConfig({required ThemeMode themeMode, required bool isVideoCallEnabled})
    : _themeMode = themeMode,
      _isVideoCallEnabled = isVideoCallEnabled;

  final ThemeMode _themeMode;
  final bool _isVideoCallEnabled;

  /// Returns the forced theme mode (System, Light, or Dark).
  ThemeMode get themeMode => _themeMode;

  /// Indicates if the video call functionality is enabled.
  bool get isVideoCallEnabled => _isVideoCallEnabled;

  @override
  List<Object?> get props => [_themeMode, _isVideoCallEnabled];
}
