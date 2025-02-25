import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation> {
  List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.white];
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80),
      itemBuilder: (context, index) {
        //print(index);
        return Center(
          child: CustomAnimatedIcon(colors: colors),
        );
      },
      padding: const EdgeInsets.all(10),
      //itemCount: 100,
    );
  }
}

class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon({
    super.key,
    required this.colors,
  });

  final List<Color> colors;

  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_arrow_outlined,
      color: widget.colors[Random().nextInt(4)],
    )
        .animate(
          onComplete: (controller) {
            setState(() {});
            controller.repeat();
          },
        )
        .rotate(
            end: Random().nextDouble() + .1,
            duration: const Duration(milliseconds: 100),
            delay: Duration(milliseconds: Random().nextInt(2000) + 500),
            curve: Curves.easeInOutCubic)
        .then()
        .fadeIn(
            duration: 1000.ms,
            delay: Duration(milliseconds: Random().nextInt(2000) + 500))
        .rotate(
            duration: Duration(milliseconds: Random().nextInt(2000) + 1000),
            curve: Curves.easeInOutCubic)
        .blur(
            duration: Duration(milliseconds: Random().nextInt(2000) + 1000),
            end: const Offset(2, 2))
        .then()
        .fadeOut(
          duration: 400.ms,
        );
  }
}
