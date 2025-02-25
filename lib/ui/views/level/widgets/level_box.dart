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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$levelNumber",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            for (int i = 0; i < 3; i++)
                              const Expanded(
                                  child: Icon(Icons.star_border_outlined))
                          ],
                        ),
                      )
                    ],
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
