part of 'index.dart';

//Landing Cubit is where the initial loading for the repository happens.
//While the fetching is being processed we show a loading spinner
class LandingScreenCubit extends Cubit<LandingScreenState> {
  final StaredGitHubRepository _gitHubRepository;
  final SqlDatabaseService<StaredGithubRepoListModel> _sqlDatabaseService;

  LandingScreenCubit(
      {required StaredGitHubRepository staredGithubRepository,
      required SqlDatabaseService<StaredGithubRepoListModel> sqlDatabaseService})
      : _gitHubRepository = staredGithubRepository,
        _sqlDatabaseService = sqlDatabaseService,
        super(LandingScreenInitialState());

  //Table name to store the repositories that were fetched
  final String tableName = 'startedRepositoriesNew3';

  //Here we store the list of fetched repo list
  List<StaredGithubRepoListModel> staredGithubRepoList = [];

  //used to show the list of repo ascend and descend
  bool sortDirectionAced = false;

  // Method to simulate loading data
  Future<void> loadStartedGitRepoList() async {
    try {
      //when loading is happening we return here so that there won't
      //be a duplicate call
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

      //saving the fetched repo on the sql database
      await saveToDatabase(data.items);

      //fetching the stored values from the sql database
      staredGithubRepoList = await _sqlDatabaseService.getAll(
          tableName: tableName, fromMap: StaredGithubRepoListModel.fromMap);

      staredGithubRepoList.sort((a, b) => b.stargazers_count!.compareTo(a.stargazers_count!));

      emit(LandingScreenSuccessState());

      //closing the database after the CRUD operation
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

  //used to sort the repo list on the table
  void onSortCallBack(int columnIndex, bool sortAscending) {
    staredGithubRepoList.sort((a, b) => sortDirectionAced
        ? a.stargazers_count!.compareTo(b.stargazers_count!)
        : b.stargazers_count!.compareTo(a.stargazers_count!));

    sortDirectionAced = !sortDirectionAced;
    emit(LandingScreenSuccessState());
  }

  //used to navigate to the detail page
  void onTap(bool? value, String url) {
    String rowUrl = url.replaceAll('https://api.github.com', '');
    emit(LandingScreenRowTappedState(url: rowUrl));
  }
}
