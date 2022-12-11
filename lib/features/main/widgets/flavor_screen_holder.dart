import 'package:flutter/material.dart';

class FlavorScreenHolder extends StatefulWidget {
  const FlavorScreenHolder({
    super.key,
    required this.active,
    required this.builder,
  });

  final bool active;
  final WidgetBuilder builder;

  @override
  State<FlavorScreenHolder> createState() => _FlavorScreenHolderState();
}

class _FlavorScreenHolderState extends State<FlavorScreenHolder>
    with SingleTickerProviderStateMixin<FlavorScreenHolder> {
  late final AnimationController _animationController;

  late bool _activated;
  late bool _ignoring;
  late bool _offstage;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );

    if (widget.active) {
      _activated = true;
      _ignoring = false;
      _offstage = false;
      _animationController.value = _animationController.upperBound;
    } else {
      _activated = false;
      _ignoring = true;
      _offstage = true;
    }
  }

  @override
  void didUpdateWidget(FlavorScreenHolder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.active != oldWidget.active) {
      if (widget.active) {
        _activated = true;
        _ignoring = false;
        _offstage = false;
        _animationController.forward();
      } else {
        _ignoring = true;
        _animationController.reverse().whenComplete(() {
          setState(() {
            _offstage = true;
          });
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: _offstage,
      child: IgnorePointer(
        ignoring: _ignoring,
        child: FadeTransition(
          opacity: _animationController.drive(CurveTween(curve: Curves.fastOutSlowIn)),
          child: _activated ? widget.builder(context) : const SizedBox(),
        ),
      ),
    );
  }
}
