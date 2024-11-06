part of 'index.dart';
//used to serialize the started git repo list model

class StartedGithubRepoListWrapper {
  final int totalCount;
  final bool incompleteResults;
  final List<StaredGithubRepoListModel> items;

  StartedGithubRepoListWrapper({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  // Factory constructor to create an instance from a map (typically a JSON response)
  factory StartedGithubRepoListWrapper.fromMap(Map<String, dynamic> map) {
    return StartedGithubRepoListWrapper(
      totalCount: map['total_count'] as int,
      incompleteResults: map['incomplete_results'] as bool,
      items: (map['items'] as List<dynamic>)
          .map((item) => StaredGithubRepoListModel.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalCount': totalCount,
      'incompleteResults': incompleteResults,
      'items': items,
    };
  }
}

class StaredGithubRepoListModel {
  final int id;
  final String name;
  final String url;
  final int? stargazers_count;  // Nullable to handle potential missing data

  StaredGithubRepoListModel({
    required this.id,
    required this.name,
    required this.url,
    this.stargazers_count,
  });

  // Convert a map into a StaredGithubRepoListModel object
  factory StaredGithubRepoListModel.fromMap(Map<String, dynamic> map) {
    return StaredGithubRepoListModel(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      stargazers_count: map['stargazers_count'] as int?,  // Safely cast to int? in case of null
    );
  }

  // Convert to Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'stargazers_count': stargazers_count,
    };
  }


  // Convert a list of maps into a list of StaredGithubRepoListModel objects
  static List<StaredGithubRepoListModel> fromMapList(List<Map<String, dynamic>> maps) {
    return maps.map((map) => StaredGithubRepoListModel.fromMap(map)).toList();
  }
}