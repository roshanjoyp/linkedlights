import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:linked_lights/ui/views/level/widgets/level_box.dart';
import 'package:linked_lights/ui/views/level/widgets/light_tile_mini.dart';
import 'package:stacked/stacked.dart';

import 'level_viewmodel.dart';

class LevelView extends StackedView<LevelViewModel> {
  const LevelView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LevelViewModel viewModel,
    Widget? child,
  ) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Select a Level")),
      //backgroundColor: Colors.black,
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                      minHeight: 100,
                      maxHeight: 100,
                      child: Container(
                        height: 100.0,
                        width: size.width,
                        color: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16,
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < 5; i++)
                              Expanded(
                                child: Hero(
                                  tag: "_$i",
                                  child: LightTileMini(
                                    index: i,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )),
                  pinned: true,
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LevelBox(
                          levelNumber: viewModel.levels[index].id,
                          isLocked: false,
                          stars: 0,
                          onTap: () => viewModel.onPatternSelected(
                            viewModel.levels[index].id,
                          ),
                        ),
                      );
                    },
                    childCount: viewModel.levels.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100, // Two patterns per row
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1, // Square shape
                  ),
                )
              ],
            ),
    );
  }

  @override
  LevelViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LevelViewModel();

  @override
  void onViewModelReady(LevelViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.readLevelsData());
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
