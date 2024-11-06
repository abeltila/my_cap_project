part of 'index.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.startedRepoDetailScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<StaredRepoDetailScreenCubit>(
            child: const StartedRepoDetailScreen(),
            create: (context) => StaredRepoDetailScreenCubit(
              urlLauncherService: UrlLauncherService(),
              sqlDatabaseService: SqlDatabaseService(),
                gitHubRepository: StaredGitHubRepository(client: context.read<NetworkService>()),
                url: (settings.arguments as Map)['url'] as String),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
