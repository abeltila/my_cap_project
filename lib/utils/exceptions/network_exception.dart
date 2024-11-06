part of 'index.dart';

/// A base class for handling exceptions related to network requests.
class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => message;
}

class BadRequestException extends NetworkException {
  BadRequestException(super.message);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException(super.message);
}

class NotFoundException extends NetworkException {
  NotFoundException(super.message);
}

class ServerException extends NetworkException {
  ServerException(super.message);
}
