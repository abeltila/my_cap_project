part of '../index.dart';

class StaredRepoDetailScreenCubit extends Cubit<StaredRepoDetailScreenState> {
  final StaredGitHubRepository _gitHubRepository;
  final SqlDatabaseService<StaredGithubRepoDetailModel> _sqlDatabaseService;
  final UrlLauncherService _urlLauncherService;
  final String _url;
  final String tableName = 'stared_github_repo_detail';

  StaredRepoDetailScreenCubit(
      {required StaredGitHubRepository gitHubRepository,
      required String url,
        required UrlLauncherService urlLauncherService,
      required SqlDatabaseService<StaredGithubRepoDetailModel> sqlDatabaseService})
      : _gitHubRepository = gitHubRepository,
        _sqlDatabaseService = sqlDatabaseService,
        _urlLauncherService = urlLauncherService,
        _url = url,
        super(StaredRepoDetailScreenInitial()) {
    loadRepoDetail();
  }

  // Method to load repository details
  Future<void> loadRepoDetail() async {
    emit(StaredRepoDetailScreenLoading());
    try {
      // Fetch repository details using the GitHub repository class
      final StaredGithubRepoDetailModel? repoDetail =
          await _gitHubRepository.getGitHubMostStaredRepoDetail(url: _url);

      if (repoDetail == null) {
        emit(StaredRepoDetailScreenFailure('Repo Error Failed'));
        return;
      }

      String sql = StaredGithubRepoDetailModel.createTableSQL(tableName);

      await _sqlDatabaseService.database(
        tableKey: '',
        tableName: tableName,
        sqlCommand: sql
      );

      await _sqlDatabaseService.insert(
        item: repoDetail,
        tableName: tableName,
        toMap: (StaredGithubRepoDetailModel repo) => repo.toMap(),
      );

      // On successful data fetch, emit success state with data
      emit(StaredRepoDetailScreenSuccess(repoDetail));
    } catch (e) {
      logger.d(e);
      // On failure, emit failure state with an error message
      emit(StaredRepoDetailScreenFailure('Failed to load repository details: $e'));
    }
  }

  void openUrl(String url){
    try{
      _urlLauncherService.launchURL(url);
      emit(StaredRepoDetailUrlTappedState(url));
    }catch(e){
      emit(StaredRepoDetailScreenFailure('Failed to open repository url'));

    }
  }
}
