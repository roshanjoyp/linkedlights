import 'package:flutter/material.dart';
import 'package:linked_lights/ui/common/custom_icon/extended_decorated_icon.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_border.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_decoration.dart';

class LightTileMini extends StatelessWidget {
  const LightTileMini({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: (index + 1) % 4,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FittedBox(
          child: AnimatedScale(
            scale: 1.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: ExtendedDecoratedIcon(
              icon: Icon(
                Icons.play_arrow_outlined,
                color: Colors.transparent,
              ),
              decoration: IconDecoration(
                border: IconBorder(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
