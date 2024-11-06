part of 'index.dart';

class LandingScreenCubit extends Cubit<LandingScreenState> {
  final StaredGitHubRepository _gitHubRepository;
  final SqlDatabaseService<StaredGithubRepoListModel> _sqlDatabaseService;

  List<StaredGithubRepoListModel> staredGithubRepoList = [];

  bool sortDirectionAced = false;

  LandingScreenCubit(
      {required StaredGitHubRepository staredGithubRepository,
      required SqlDatabaseService<StaredGithubRepoListModel> sqlDatabaseService})
      : _gitHubRepository = staredGithubRepository,
        _sqlDatabaseService = sqlDatabaseService,
        super(LandingScreenInitialState());

  final String tableName = 'startedRepositoriesNew3';

  // Method to simulate loading data
  Future<void> loadStartedGitRepoList() async {
    try {
      if (state is LandingScreenLoadingState) {
        return;
      }

      emit(LandingScreenLoadingState());
      // Ensure the database is fully initialized before using it
      await _sqlDatabaseService.database(
          tableName: tableName,
          tableKey: "id INTEGER PRIMARY KEY, "
              "name TEXT NOT NULL, "
              "url TEXT NOT NULL,"
              "stargazers_count INTEGER");

      StartedGithubRepoListWrapper? data =
          await _gitHubRepository.getGitHubMostStaredRepoList(limit: '100', page: '1');

      await saveToDatabase(data.items);

      staredGithubRepoList = await _sqlDatabaseService.getAll(
          tableName: tableName, fromMap: StaredGithubRepoListModel.fromMap);

      staredGithubRepoList.sort((a, b) => b.stargazers_count!.compareTo(a.stargazers_count!));

      emit(LandingScreenSuccessState());
      await _sqlDatabaseService.close();
    } catch (e) {
      // On failure, emit failure state with an error message
      emit(LandingScreenFailureState('Failed to load data: $e'));
    }
  }

  // Method to save each repository item in the database
  Future<void> saveToDatabase(List<StaredGithubRepoListModel> items) async {
    for (var repo in items) {
      await _sqlDatabaseService.insert(
        item: repo,
        tableName: tableName,
        toMap: (StaredGithubRepoListModel repo) => repo.toMap(),
      );
    }
  }

  void onSortCallBack(int columnIndex, bool sortAscending) {
    staredGithubRepoList.sort((a, b) => sortDirectionAced
        ? a.stargazers_count!.compareTo(b.stargazers_count!)
        : b.stargazers_count!.compareTo(a.stargazers_count!));

    sortDirectionAced = !sortDirectionAced;
    emit(LandingScreenSuccessState());
  }

  void onTap(bool? value, String url) {
    String rowUrl = url.replaceAll('https://api.github.com', '');
    emit(LandingScreenRowTappedState(url: rowUrl));
  }
}
