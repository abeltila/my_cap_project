part of 'index.dart';
/// Abstract base class defining the GitHub repository operations.
abstract class BaseGitHubRepository {
  /// Fetches a list of the most starred GitHub repositories.
  ///
  /// [limit] specifies the number of repositories to fetch per page.
  /// [page] specifies the page number of the results.
  Future<StartedGithubRepoListWrapper> getGitHubMostStaredRepoList(
      {required String limit, required String page});

  /// Fetches details of a specific starred GitHub repository.
  ///
  /// [url] is the API endpoint for fetching the repository details.
  Future<StaredGithubRepoDetailModel?> getGitHubMostStaredRepoDetail({required String url});
}

/// Implementation of [BaseGitHubRepository] to interact with the GitHub API.
class StaredGitHubRepository extends BaseGitHubRepository {
  final NetworkService _client;

  /// Constructor for [StaredGitHubRepository].
  ///
  /// Accepts a [NetworkService] client instance to make network requests.
  StaredGitHubRepository({required NetworkService client}) : _client = client;

  /// Fetches details of a specific starred GitHub repository.
  ///
  /// [url] is the API endpoint for fetching repository details.
  /// Returns a [StaredGithubRepoDetailModel] object if successful, otherwise null.
  @override
  Future<StaredGithubRepoDetailModel?> getGitHubMostStaredRepoDetail({required String url}) async {
    try {
      // Perform GET request to fetch repository details.
      Map<String, dynamic> res = await _client.get(
        url: url,
      );

      // Convert response map to StaredGithubRepoDetailModel.
      return StaredGithubRepoDetailModel.fromMap(res);
    } catch (e) {
      // Log any errors encountered.
      logger.d(e);
      rethrow;
    }
  }

  /// Fetches a list of the most starred GitHub repositories.
  ///
  /// [limit] specifies the number of repositories per page.
  /// [page] specifies the page number of the results.
  /// Returns a [StartedGithubRepoListWrapper] object containing the repository list.
  @override
  Future<StartedGithubRepoListWrapper> getGitHubMostStaredRepoList(
      {required String limit, required String page}) async {
    try {
      // Perform GET request to fetch the list of most starred repositories.
      Map<String, dynamic> res = await _client.get(
        url: '/search/repositories?q=language:php&sort=stars&order=desc&page=$page&per_page=$limit',
      );

      // Convert response map to StartedGithubRepoListWrapper.
      return StartedGithubRepoListWrapper.fromMap(res);
    } catch (e) {
      // Rethrow any errors encountered during the request.
      rethrow;
    }
  }
}
