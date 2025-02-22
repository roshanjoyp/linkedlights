import 'package:flutter/material.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_border.dart';

class IconDecoration {
  /// {@macro icon_decoration}
  const IconDecoration({
    this.border,
    this.gradient,
  });

  /// A border to draw above the icon color or [gradient].
  final IconBorder? border;

  /// Apply a gradient to the icon. If this is specified the [Icon.color]
  /// property has no effect.
  ///
  /// **Gradients are supported on Flutter Web only with the [canvaskit renderer](https://docs.flutter.dev/platform-integration/web/renderers)**
  final Gradient? gradient;
}
