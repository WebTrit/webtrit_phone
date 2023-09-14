import 'package:flutter/material.dart';

class NoDataPlaceholder extends StatelessWidget {
  const NoDataPlaceholder({
    super.key,
    this.icon,
    this.iconSize = 64.0,
    this.iconColor,
    this.iconPadding,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.contentTextAlign = TextAlign.center,
    this.actions,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
  });

  final Widget? icon;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final Widget? content;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentTextStyle;
  final TextAlign? contentTextAlign;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? actionsPadding;
  final MainAxisAlignment? actionsAlignment;
  final OverflowBarAlignment? actionsOverflowAlignment;
  final VerticalDirection? actionsOverflowDirection;
  final double? actionsOverflowButtonSpacing;
  final EdgeInsetsGeometry? buttonPadding;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final TextDirection? textDirection = Directionality.maybeOf(context);

    Widget? iconWidget;
    Widget? contentWidget;
    Widget? actionsWidget;

    final icon = this.icon;
    final content = this.content;
    final actions = this.actions;

    if (icon != null) {
      final bool belowIsContent = content != null;
      final EdgeInsets defaultIconPadding = EdgeInsets.only(
        left: 24.0,
        top: 24.0,
        right: 24.0,
        bottom: belowIsContent ? 0.0 : 24.0,
      );
      final EdgeInsets effectiveIconPadding = iconPadding?.resolve(textDirection) ?? defaultIconPadding;
      iconWidget = Padding(
        padding: effectiveIconPadding,
        child: IconTheme(
          data: IconThemeData(
            size: iconSize,
            color: iconColor ?? themeData.colorScheme.secondaryContainer,
          ),
          child: icon,
        ),
      );
    }

    if (content != null) {
      final bool aboveIsIcon = icon != null;
      final bool belowIsActions = actions != null;
      final EdgeInsets defaultContentPadding = EdgeInsets.only(
        left: 24.0,
        top: aboveIsIcon ? 0.0 : 24.0,
        right: 24.0,
        bottom: belowIsActions ? 0.0 : 24.0,
      );
      final EdgeInsets effectiveContentPadding = contentPadding?.resolve(textDirection) ?? defaultContentPadding;
      contentWidget = Padding(
        padding: effectiveContentPadding,
        child: DefaultTextStyle(
          style: contentTextStyle ?? themeData.textTheme.titleMedium!,
          textAlign: contentTextAlign,
          child: content,
        ),
      );
    }

    if (actions != null) {
      const EdgeInsets defaultActionsPadding = EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      );
      final double spacing = (buttonPadding?.horizontal ?? 16) / 2;
      actionsWidget = Padding(
        padding: actionsPadding ?? defaultActionsPadding,
        child: OverflowBar(
          alignment: actionsAlignment ?? MainAxisAlignment.center,
          spacing: spacing,
          overflowAlignment: actionsOverflowAlignment ?? OverflowBarAlignment.end,
          overflowDirection: actionsOverflowDirection ?? VerticalDirection.down,
          overflowSpacing: actionsOverflowButtonSpacing ?? 0,
          children: actions,
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconWidget != null) iconWidget,
          if (contentWidget != null) contentWidget,
          if (actionsWidget != null) actionsWidget,
        ],
      ),
    );
  }
}
