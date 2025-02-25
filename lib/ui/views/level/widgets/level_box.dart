import 'package:flutter/material.dart';

class LevelBox extends StatelessWidget {
  final int levelNumber;
  final bool isLocked;
  final int stars;
  final VoidCallback onTap;

  const LevelBox({
    required this.levelNumber,
    this.isLocked = true,
    this.stars = 0,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.withAlpha(50),
                ),
                child: Center(
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$levelNumber",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
