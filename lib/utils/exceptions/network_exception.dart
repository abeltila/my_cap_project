part of 'index.dart';

/// A base class for handling exceptions related to network requests.
///
/// [NetworkException] holds a [message] describing the error encountered.
class NetworkException implements Exception {
  final String message;

  /// Creates a [NetworkException] with a specified error [message].
  NetworkException(this.message);

  /// Returns the error message as a string representation of the exception.
  @override
  String toString() => message;
}

/// Exception thrown when a bad request (HTTP 400) is encountered.
class BadRequestException extends NetworkException {
  /// Creates a [BadRequestException] with a specified error [message].
  BadRequestException(super.message);
}

/// Exception thrown when an unauthorized request (HTTP 401) is encountered.
class UnauthorizedException extends NetworkException {
  /// Creates an [UnauthorizedException] with a specified error [message].
  UnauthorizedException(super.message);
}

/// Exception thrown when a requested resource is not found (HTTP 404).
class NotFoundException extends NetworkException {
  /// Creates a [NotFoundException] with a specified error [message].
  NotFoundException(super.message);
}

/// Exception thrown when a server error (HTTP 500) is encountered.
class ServerException extends NetworkException {
  /// Creates a [ServerException] with a specified error [message].
  ServerException(super.message);
}
