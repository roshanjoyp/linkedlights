import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:linked_lights/ui/views/game/game_view.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text("Select a Level")),
      backgroundColor: Colors.black,
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                ...viewModel.levels.entries
                    .where((entry) => int.parse(entry.key) >= 1)
                    .expand((entry) => [
                          SliverStickyHeader(
                            header: Container(
                              height: 200.0,
                              color: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16),
                              margin: const EdgeInsets.only(bottom: 8),
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    for (int i = 0;
                                        i < int.parse(entry.key);
                                        i++)
                                      LightTile(
                                        isOnLevelScreen: true,
                                        index: i,
                                        totalLights: int.parse(entry.key),
                                        isOn: false,
                                        onLightTapped: (i) {},
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            sliver: SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LevelBox(
                                      level: entry.key,
                                      patternIndex: index + 1,
                                      onTap: () => viewModel.onPatternSelected(
                                          entry.key,
                                          index,
                                          entry.value[index][0]),
                                    ),
                                  );
                                },
                                childCount: entry.value.length,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100, // Two patterns per row
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1, // Square shape
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 50,
                            ),
                          )
                        ])
                    .toList(),
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
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

class LevelCard extends StatelessWidget {
  final String level;
  final int patternsCount;
  final VoidCallback onTap;

  const LevelCard({
    required this.level,
    required this.patternsCount,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text("Level $level"),
        subtitle: Text("$patternsCount pattern(s) available"),
        onTap: onTap,
      ),
    );
  }
}

/// Level Box for Level 3 and beyond (Grid Items)
class LevelBox extends StatelessWidget {
  final String level;
  final int patternIndex;
  final VoidCallback onTap;

  const LevelBox({
    required this.level,
    required this.patternIndex,
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
                        "$patternIndex",
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
