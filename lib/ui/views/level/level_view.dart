import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // SliverList for Level 1 & Level 2 (Single Items)

                // SliverGrid for Level 3 and beyond (Multiple Items)
                ...viewModel.levels.entries
                    .where((entry) => int.parse(entry.key) >= 1)
                    .map(
                      (entry) => SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return LevelBox(
                                level: entry.key,
                                patternIndex: index + 1,
                                onTap: () => viewModel.onPatternSelected(
                                    entry.key, index, entry.value[index][0]),
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
                    )
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
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Level $level - $patternIndex",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
