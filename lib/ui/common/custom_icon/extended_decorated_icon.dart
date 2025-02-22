import 'package:flutter/material.dart';
import 'package:linked_lights/ui/common/custom_icon/gradient_icon.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_decoration.dart';

class ExtendedDecoratedIcon extends StatelessWidget {
  const ExtendedDecoratedIcon({
    Key? key,
    required this.icon,
    this.decoration,
  }) : super(key: key);

  final Icon icon;
  final IconDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final iconData = icon.icon!;
    final textDirection = icon.textDirection ?? Directionality.of(context);
    final iconTheme = IconTheme.of(context);
    final iconSize = icon.size ?? iconTheme.size ?? 24.0;
    final iconOpacity = iconTheme.opacity ?? 1.0;
    final border = decoration?.border;
    final gradient = decoration?.gradient;
    final shadows = icon.shadows;

    Color iconColor = icon.color ?? iconTheme.color!;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    final TextStyle iconStyle = TextStyle(
      inherit: false,
      color: iconColor,
      fontSize: iconSize,
      fontFamily: iconData.fontFamily,
      package: iconData.fontPackage,
      shadows: shadows,
    );

    Widget iconWidget = RichText(
      overflow: TextOverflow.visible,
      textDirection: textDirection,
      text: TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: iconStyle,
      ),
    );

    Widget? gradientWidgetCpy;
    if (gradient != null) {
      iconWidget = GradientIcon(
        icon: iconData,
        size: iconSize,
        gradient: gradient,
        textDirection: textDirection,
        style: iconStyle,
      );

      // Creates a copy to ensure the original gradient is not modified.
      gradientWidgetCpy = GradientIcon(
        icon: iconData,
        size: iconSize,
        gradient: gradient,
        textDirection: textDirection,
        style: iconStyle,
      );
    }

    if (iconData.matchTextDirection) {
      switch (textDirection) {
        case TextDirection.rtl:
          iconWidget = Transform(
            transform: Matrix4.identity()..scale(-1.0, 1, 1),
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconWidget,
          );
          break;
        case TextDirection.ltr:
          break;
      }
    }

    if (border != null) {
      // Remove shadows from the widget as it will be displayed by the border.
      iconWidget = gradientWidgetCpy ??
          RichText(
            overflow: TextOverflow.visible,
            textDirection: textDirection,
            text: TextSpan(
              text: String.fromCharCode(iconData.codePoint),
              style: iconStyle.copyWith(shadows: []),
            ),
          );
      iconWidget = Stack(
        alignment: Alignment.center,
        textDirection: textDirection,
        children: [
          RichText(
            overflow: TextOverflow.visible,
            textDirection: textDirection,
            textAlign: TextAlign.center,
            text: TextSpan(
              text: String.fromCharCode(iconData.codePoint),
              style: iconStyle.copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeCap = StrokeCap.square
                  ..strokeJoin = StrokeJoin.miter
                  ..strokeWidth = border.width * .5
                  ..color = border.color,
              ),
            ),
          ),
          iconWidget,
        ],
      );
    }

    return Semantics(
      label: icon.semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Center(child: iconWidget),
        ),
      ),
    );
  }
}
