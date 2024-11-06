part of '../index.dart';

// Abstract base state class for the stared repo detail screen
abstract class StaredRepoDetailScreenState {}

// Initial state for the stared repo detail screen
class StaredRepoDetailScreenInitial extends StaredRepoDetailScreenState {}

// Loading state to show a loading indicator on the repo detail screen
class StaredRepoDetailScreenLoading extends StaredRepoDetailScreenState {}

//state used to emit user tap on rul
class StaredRepoDetailUrlTappedState extends StaredRepoDetailScreenState {
  final String url;
  StaredRepoDetailUrlTappedState(this.url);

}

// Success state with repository detail data when successfully loaded
class StaredRepoDetailScreenSuccess extends StaredRepoDetailScreenState {
  final StaredGithubRepoDetailModel? repoDetail;

  StaredRepoDetailScreenSuccess(this.repoDetail);
}

// Failure state to handle and display errors on the repo detail screen
class StaredRepoDetailScreenFailure extends StaredRepoDetailScreenState {
  final String errorMessage;

  StaredRepoDetailScreenFailure(this.errorMessage);
}
