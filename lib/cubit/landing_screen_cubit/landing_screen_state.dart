part of 'index.dart';

// Abstract base state class for the landing screen
abstract class LandingScreenState {}

// Initial state for the landing screen
class LandingScreenInitialState extends LandingScreenState {
  LandingScreenInitialState();
}

// Loading state to show a loading indicator on the landing screen
class LandingScreenLoadingState extends LandingScreenState {}

// Success state with data or UI update when landing screen loads successfully
class LandingScreenSuccessState extends LandingScreenState {

  LandingScreenSuccessState();
}


// Success state with data or UI update when landing screen loads successfully
class LandingScreenRowTappedState extends LandingScreenState {
  final String url;
  LandingScreenRowTappedState({required this.url});
}


class LandingScreenFetchMoreState extends LandingScreenState{}

// Failure state to handle and display errors on the landing screen
class LandingScreenFailureState extends LandingScreenState {
  final String errorMessage;

  LandingScreenFailureState(this.errorMessage);
}
