import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubits/theme/theme_cubit.dart';
import 'logic/cubits/theme/theme_state.dart';
import 'logic/cubits/navigation/navigation_cubit.dart';
import 'repositories/portfolio_repository.dart';
import 'screens/home_screen.dart';
import 'utils/theme_config.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PortfolioRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: repository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => NavigationCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Raghad Hamsho — Flutter Developer',
              debugShowCheckedModeBanner: false,
              theme: ThemeConfig.light,
              darkTheme: ThemeConfig.dark,
              themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
