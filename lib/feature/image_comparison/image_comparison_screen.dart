import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_test/feature/image_comparison/cubit/image_comparison_cubit.dart';
import 'package:solid_test/feature/image_comparison/widget/comparison_result.dart';
import 'package:solid_test/feature/image_comparison/widget/image_select.dart';
import 'package:solid_test/utility/app_theme.dart';
import 'package:solid_test/utility/cubit/theme_cubit.dart';
import 'package:solid_test/widget/primary_elevated_button.dart';
import 'package:solid_test/widget/primary_outlined_button.dart';

class ImageComparisonScreen extends StatefulWidget {
  @override
  _ImageComparisonScreenState createState() => _ImageComparisonScreenState();
}

class _ImageComparisonScreenState extends State<ImageComparisonScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageComparisonCubit, ImageComparisonState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.theme.appColors.background,
          appBar: AppBar(
            backgroundColor: context.theme.appColors.background,
            surfaceTintColor: context.theme.appColors.background,
            title: const Text('Image Comparison Test'),
            actions: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Switch(
                    activeColor: context.theme.appColors.accent,
                    value: state.themeMode == ThemeMode.dark,
                    onChanged: (theme) {
                      context.read<ThemeCubit>().switchTheme();
                    },
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ImageSelect(
                                showImage: state.firstImageNotNull,
                                imagePath: state.firstImageFile?.path,
                                buttonTitle: 'Select image 1',
                                buttonCallback: () => context
                                    .read<ImageComparisonCubit>()
                                    .pickFirstImage(),
                              ),
                              const SizedBox(width: 16),
                              ImageSelect(
                                showImage: state.secondImageNotNull,
                                imagePath: state.secondImageFile?.path,
                                buttonTitle: 'Select image 2',
                                buttonCallback: () {
                                  context
                                      .read<ImageComparisonCubit>()
                                      .pickSecondImage();
                                },
                              ),
                            ],
                          ),
                          const ComparisonResult(),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryElevatedButton(
                        title: 'Compare Images',
                        onPressed: () {
                          context.read<ImageComparisonCubit>().compareImages();
                        },
                        isEnabled: state.imageNotNull,
                      ),
                      const SizedBox(width: 8),
                      PrimaryOutlinedButton(
                        title: 'Clean selected image',
                        onPressed: () {
                          context
                              .read<ImageComparisonCubit>()
                              .cleanImageState();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
