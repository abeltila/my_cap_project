part of 'index.dart';

//StartedGithub Repo Detail model
class StaredGithubRepoDetailModel {
  final int id;
  final int watchersCount;
  final int stargazersCount;
  final int openIssuesCount;
  final String name;
  final String url;
  final String html_url;
  final String createdAt;
  final String lastPushed;
  final String fullName;
  final int forksCount;
  final String? description;
  final Owner owner;
  final String homepage;

  StaredGithubRepoDetailModel({
    required this.id,
    required this.watchersCount,
    required this.stargazersCount,
    required this.openIssuesCount,
    required this.name,
    required this.url,
    required this.html_url,
    required this.createdAt,
    required this.lastPushed,
    required this.fullName,
    required this.forksCount,
    this.description,
    required this.owner,
    required this.homepage,
  });

  // Factory constructor to create an instance from a map
  factory StaredGithubRepoDetailModel.fromMap(Map<String, dynamic> map) {
    return StaredGithubRepoDetailModel(
      id: map['id'] as int,
      watchersCount: map['watchers_count'] as int,
      stargazersCount: map['stargazers_count'] as int,
      openIssuesCount: map['open_issues_count'] as int,
      name: map['name'] as String,
      url: map['url'] as String,
      html_url: map['html_url'] as String,
      createdAt: map['created_at'] as String,
      lastPushed: map['pushed_at'] as String,
      fullName: map['full_name'] as String,
      forksCount: map['forks_count'] as int,
      description: map['description'] as String?,
      owner: Owner.fromMap(map['owner'] as Map<String, dynamic>),
      homepage: map['homepage'] as String,
    );
  }

  // Convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'watchers_count': watchersCount,
      'stargazers_count': stargazersCount,
      'open_issues_count': openIssuesCount,
      'name': name,
      'url': url,
      'html_url': html_url,
      'created_at': createdAt,
      'pushed_at': lastPushed,
      'full_name': fullName,
      'forks_count': forksCount,
      'description': description,
      'homepage': homepage,
    };
  }

  static String createTableSQL(String tableName) {
    return '''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        watchers_count INTEGER,
        stargazers_count INTEGER,
        open_issues_count INTEGER,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        html_url TEXT NOT NULL,
        created_at TEXT,
        pushed_at TEXT,
        full_name TEXT,
        forks_count INTEGER,
        description TEXT,
        homepage TEXT
      );
    ''';
  }
}
