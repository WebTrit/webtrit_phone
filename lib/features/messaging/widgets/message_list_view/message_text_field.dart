import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import 'audio_recorder_bottom_sheet.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({
    required this.controller,
    required this.onSend,
    this.onChanged,
    this.onAddAttachment,
    this.onAddRecording,
    super.key,
  });

  final TextEditingController controller;
  final void Function() onSend;
  final void Function(String)? onChanged;
  final void Function(List<String>)? onAddAttachment;
  final void Function(String)? onAddRecording;

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: colorScheme.surface.withAlpha(200),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: widget.controller,
                      onFieldSubmitted: (_) {
                        if (value.isNotEmpty) widget.onSend();
                      },
                      onChanged: (v) {
                        setState(() => value = v);
                        widget.onChanged?.call(v);
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: context.l10n.messaging_MessageField_hint,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0, maxWidth: 40, maxHeight: 40),
                        isDense: false,
                        isCollapsed: false,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.onAddAttachment != null)
                      SizedBox(
                        width: 28,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.attach_file, size: 20),
                          color: colorScheme.primary,
                          onPressed: pickAttachment,
                        ),
                      ),
                    if (widget.onAddRecording != null)
                      SizedBox(
                        width: 28,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.mic, size: 20),
                          color: colorScheme.primary,
                          onPressed: recordAudio,
                        ),
                      ),
                  ],
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 600),
                  sizeCurve: Curves.elasticOut,
                  firstChild: const SizedBox(width: 8, height: 8),
                  secondChild: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.send, size: 24, color: colorScheme.primary),
                    ),
                    onTap: () {
                      if (value.isNotEmpty) {
                        widget.onSend();
                        setState(() => value = '');
                      }
                    },
                  ),
                  crossFadeState: value.isNotEmpty ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickAttachment() async {
    if (Platform.isAndroid) {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result == null) return;

      final pickedPaths = result.paths.whereType<String>().toList();
      widget.onAddAttachment?.call(pickedPaths);
    } else if (Platform.isIOS) {
      final result = await showCupertinoModalPopup<List<String>>(
          context: context,
          builder: (popupCtx) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.media,
                    );
                    if (!popupCtx.mounted) return;
                    final paths = result?.paths.whereType<String>().toList() ?? [];
                    popupCtx.router.maybePop(paths);
                  },
                  child: Text(context.l10n.messaging_MessageField_pick_gallery),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.audio,
                    );
                    if (!popupCtx.mounted) return;
                    final paths = result?.paths.whereType<String>().toList() ?? [];
                    popupCtx.router.maybePop(paths);
                  },
                  child: Text(context.l10n.messaging_MessageField_pick_audio),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.any,
                    );
                    if (!popupCtx.mounted) return;
                    final paths = result?.paths.whereType<String>().toList() ?? [];
                    popupCtx.router.maybePop(paths);
                  },
                  child: Text(context.l10n.messaging_MessageField_pick_files),
                ),
              ],
            );
          });

      if (result == null || result.isEmpty) return;
      if (mounted == false) return;
      widget.onAddAttachment?.call(result);
    }
  }

  recordAudio() async {
    final result = await showModalBottomSheet<String?>(
      context: context,
      builder: (_) => const AudioRecorderBottomSheet(),
    );
    if (result == null) return;
    if (mounted == false) return;
    widget.onAddRecording?.call(result);
  }
}
