import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cap_project/config/index.dart';
import 'package:my_cap_project/cubit/index.dart';
import 'package:my_cap_project/repository/index.dart';
import 'package:my_cap_project/screen/landing_screen/index.dart';
import 'package:my_cap_project/services/index.dart';

//Navigation key is a global key used to to fetch the global context of the app when
//there is no context implementation.
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NetworkService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LandingScreenCubit>(
            create: (context) => LandingScreenCubit(
              sqlDatabaseService: SqlDatabaseService(),
                staredGithubRepository:
                    StaredGitHubRepository(client: context.read<NetworkService>()))
              ..loadStartedGitRepoList(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: const TextTheme().copyWith(
              bodySmall: const TextStyle(color: AppColorsConfig.surface),
              bodyMedium: const TextStyle(color: AppColorsConfig.surface),
              bodyLarge: const TextStyle(color: AppColorsConfig.surface),
              labelSmall: const TextStyle(color: AppColorsConfig.surface),
              labelMedium: const TextStyle(color: AppColorsConfig.surface),
              labelLarge: const TextStyle(color: AppColorsConfig.surface),
              displaySmall: const TextStyle(color: AppColorsConfig.surface),
              displayMedium: const TextStyle(color: AppColorsConfig.surface),
              displayLarge: const TextStyle(color: AppColorsConfig.surface),
            ),
          ),
          home: const LandingScreen(),
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
