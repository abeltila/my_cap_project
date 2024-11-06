part of 'index.dart';

abstract class BaseGitHubRepository {
  Future<StartedGithubRepoListWrapper> getGitHubMostStaredRepoList(
      {required String limit, required String page});

  Future<StaredGithubRepoDetailModel?> getGitHubMostStaredRepoDetail({required String url});
}

class StaredGitHubRepository extends BaseGitHubRepository {
  final NetworkService _client;

  StaredGitHubRepository({required NetworkService client}) : _client = client;

  @override
  Future<StaredGithubRepoDetailModel?> getGitHubMostStaredRepoDetail({required String url}) async {
    try {
      Map<String, dynamic> res = await _client.get(
        url: url,
      );

      return StaredGithubRepoDetailModel.fromMap(res);
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

  @override
  Future<StartedGithubRepoListWrapper> getGitHubMostStaredRepoList(
      {required String limit, required String page}) async {
    try {
      Map<String, dynamic> res = await _client.get(
        url: '/search/repositories?q=language:php&sort=stars&order=desc&page=$page&per_page=$limit',
      );
      return StartedGithubRepoListWrapper.fromMap(res);
    } catch (e) {
      rethrow;
    }
  }
}
