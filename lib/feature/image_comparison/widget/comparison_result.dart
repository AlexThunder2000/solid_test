import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_test/feature/image_comparison/cubit/image_comparison_cubit.dart';
import 'package:solid_test/utility/app_theme.dart';
import 'package:solid_test/utility/text_style_source.dart';

class ComparisonResult extends StatelessWidget {
  const ComparisonResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageComparisonCubit, ImageComparisonState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.status == ImageComparisonStatus.loading)
                CircularProgressIndicator(
                  color: context.theme.appColors.accent,
                ),
              if (state.status == ImageComparisonStatus.error)
                const Text("Сan't compare images with different sizes."),
              if (state.status == ImageComparisonStatus.success)
                Column(
                  children: [
                    Text(
                      state.differencePercent != 0
                          ? 'The images have a'
                              ' ${state.differencePercent?.toStringAsFixed(2)}%'
                              ' difference.\nThe differences are marked in'
                              ' red in the image below.'
                          : 'The images are the same',
                      textAlign: TextAlign.center,
                      style: TextStyleSource.lato14rg140,
                    ),
                    const SizedBox(height: 16),
                    Image.memory(state.highlightedEncodedImage!),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
