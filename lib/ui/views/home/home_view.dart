import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      viewModel.navigateToLevels();
                    },
                    child: const Text(
                      "PLAY",
                      style: TextStyle(
                          fontSize: 80,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Text(
                    "SETTINGS",
                    style: TextStyle(
                        fontSize: 80,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
