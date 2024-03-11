import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_test/feature/image_comparison/cubit/image_comparison_cubit.dart';
import 'package:solid_test/feature/image_comparison/image_comparison_screen.dart';
import 'package:solid_test/utility/app_theme.dart';
import 'package:solid_test/utility/cubit/theme_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImageComparisonCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()..initialTheme(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            home: ImageComparisonScreen(),
          );
        },
      ),
    ),
  );
}
