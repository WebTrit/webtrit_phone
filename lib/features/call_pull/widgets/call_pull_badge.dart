import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_pull/call_pull.dart';

class CallPullBadge extends StatefulWidget {
  const CallPullBadge({required this.pullableCalls, super.key});

  final List<PullableCall> pullableCalls;

  @override
  State<CallPullBadge> createState() => _CallPullBadgeState();
}

class _CallPullBadgeState extends State<CallPullBadge> with TickerProviderStateMixin {
  late final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final callPullCubit = context.read<CallPullCubit>();
  late final callBloc = context.read<CallBloc>();

  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      if (!mounted) return false;
      controller.repeat(max: 0.38, reverse: true, count: 4);
      await Future.delayed(Duration(seconds: 1 + Random().nextInt(5)));
      return true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onTap() async {
    final result = await showDialog(
      context: context,
      builder: (_) => PullableCallsDialog(callPullCubit: callPullCubit, callBloc: callBloc),
    );

    if (!mounted) return;
    if (result is PullableCall) onPickUp(result);
  }

  void onPickUp(PullableCall pullableCall) {
    callBloc.add(
      CallControlEvent.started(
        number: pullableCall.remoteNumber,
        video: false,
        replaces: '${pullableCall.callId};from-tag=${pullableCall.localTag};to-tag=${pullableCall.remoteTag}',
        displayName: pullableCall.remoteDisplayName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final contentColor = colorScheme.onPrimary;

        return Material(
          color: colorScheme.tertiary,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RotationTransition(
                    turns: controller.drive(
                      Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.elasticInOut)),
                    ),
                    child: Stack(
                      children: [
                        Icon(Icons.call_outlined, size: 16, color: contentColor),
                        if (widget.pullableCalls.length > 1)
                          Positioned(
                            right: 1,
                            top: 0,
                            child: Text(
                              widget.pullableCalls.length.toString(),
                              style: TextStyle(
                                fontSize: 8,
                                color: contentColor,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          )
                        else
                          Positioned(
                            right: 1,
                            top: 1,
                            child: switch (widget.pullableCalls.first.direction) {
                              PullableCallDirection.initiator => Icon(Icons.call_made, size: 8, color: contentColor),
                              PullableCallDirection.recipient => Icon(
                                Icons.call_received,
                                size: 8,
                                color: contentColor,
                              ),
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (widget.pullableCalls.length > 1)
                    LimitedBox(
                      maxWidth: 100,
                      child: Text(
                        widget.pullableCalls.map((e) => e.displayName.split(' ').first).join(', '),
                        style: TextStyle(fontSize: 12, color: contentColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  else
                    Text(
                      widget.pullableCalls.first.displayName,
                      style: TextStyle(fontSize: 12, color: contentColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PullableCallsDialog extends StatefulWidget {
  const PullableCallsDialog({required this.callPullCubit, required this.callBloc, super.key});

  final CallPullCubit callPullCubit;
  final CallBloc callBloc;

  @override
  State<PullableCallsDialog> createState() => _PullableCallsDialogState();
}

class _PullableCallsDialogState extends State<PullableCallsDialog> {
  bool closing = false;

  void onPickUp(PullableCall pullableCall) {
    maybeClose(result: pullableCall);
  }

  void maybeClose({PullableCall? result}) {
    if (!mounted || closing) return;

    closing = true;
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocListener<CallBloc, CallState>(
        bloc: widget.callBloc,
        listenWhen: (previous, current) {
          return previous.activeCalls.length != current.activeCalls.length;
        },
        listener: (context, state) {
          maybeClose();
        },
        child: BlocConsumer<CallPullCubit, List<PullableCall>>(
          bloc: widget.callPullCubit,
          listener: (context, state) {
            if (state.isEmpty) maybeClose();
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Text(
                    context.l10n.callPullBadge_dialogTitle,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  for (final pullableCall in state) ...[callTile(pullableCall)],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget callTile(PullableCall pullableCall) {
    final colorScheme = Theme.of(context).colorScheme;
    final canPickUp = pullableCall.state == PullableCallState.confirmed;

    return Row(
      children: [
        switch (pullableCall.state) {
          PullableCallState.proceeding || PullableCallState.early => switch (pullableCall.direction) {
            PullableCallDirection.initiator => const Icon(Icons.phone_forwarded, size: 16),
            PullableCallDirection.recipient => const Icon(Icons.phone_callback, size: 16),
          },
          PullableCallState.confirmed => const Icon(Icons.phone_in_talk, size: 16),
          _ => const Icon(Icons.phone_locked, size: 16),
        },
        const SizedBox(width: 8),
        Expanded(
          child: Text(pullableCall.displayName, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
        ),
        Material(
          color: colorScheme.tertiary.withAlpha(canPickUp ? 255 : 128),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () {
              if (canPickUp) onPickUp(pullableCall);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.l10n.callPullBadge_pickupButtonTitle,
                style: TextStyle(fontSize: 14, color: colorScheme.onPrimary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
