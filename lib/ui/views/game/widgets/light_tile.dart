import 'package:flutter/material.dart';
import 'package:linked_lights/ui/common/custom_icon/extended_decorated_icon.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_border.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_decoration.dart';

class LightTile extends StatelessWidget {
  const LightTile({
    super.key,
    required this.index,
    required this.isOn,
    this.isOnLevelScreen = false,
  });

  final int index;
  final bool isOn;
  final bool isOnLevelScreen;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: (index + (isOnLevelScreen ? 1 : 0)) % 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: AnimatedScale(
            scale: isOn ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: ExtendedDecoratedIcon(
              icon: Icon(
                Icons.play_arrow_outlined,
                color: isOn ? Colors.white : Colors.transparent,
              ),
              decoration: const IconDecoration(
                border: IconBorder(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
