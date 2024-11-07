part of 'index.dart';

/// A base class defining the contract for network clients.
abstract class BaseNetworkService {
  /// Sends a GET request to the specified [url].
  Future get({required String url});

  /// Sends a POST request to the specified [url] with [data] as the body.
  Future post({required String url, required final dynamic data});

  /// Sends a PATCH request to the specified [url] with [data] as the body.
  Future patch({required String url, final dynamic data});

  /// Sends a DELETE request to the specified [url].
  Future delete({required String url});
}

/// A network service class for making HTTP requests using Dio.
class NetworkService implements BaseNetworkService {
  /// Dio client instance for making HTTP requests.
  final dio = Dio();

  NetworkService();

  /// Sends a GET request to the specified [url] and returns the response data.
  ///
  /// [url] is appended to [ AppConstants.baseUrl] to form the full endpoint URL.
  /// Throws an exception if the request fails.
  @override
  Future get({required String url}) async {
    final dynamic responseJson;
    try {
      final response = await dio.get(
        AppConstants.baseUrl + url,
      );

      // Process and return the response data.
      responseJson = _response(response);
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  /// Sends a POST request to the specified [url] with [data] as the request body.
  ///
  /// [url] is appended to [ AppConstants.baseUrl] to form the full endpoint URL.
  /// Throws an exception if the request fails.
  @override
  Future post({
    required String url,
    required data,
  }) async {
    final dynamic responseJson;
    try {
      final response = await dio.post(AppConstants.baseUrl + url, data: jsonEncode(data));

      // Process and return the response data.
      responseJson = _response(response);
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  /// Sends a PATCH request to the specified [url] with [data] as the request body.
  ///
  /// [url] is appended to [ AppConstants.baseUrl] to form the full endpoint URL.
  /// Throws an exception if the request fails.
  @override
  Future patch({required String url, data}) async {
    final dynamic responseJson;
    try {
      final response = await dio.patch(AppConstants.baseUrl + url, data: jsonEncode(data));

      // Process and return the response data.
      responseJson = _response(response);
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  /// Sends a DELETE request to the specified [url].
  ///
  /// [url] is appended to [ AppConstants.baseUrl] to form the full endpoint URL.
  /// Throws an exception if the request fails.
  @override
  Future delete({required String url}) async {
    final dynamic responseJson;
    try {
      final response = await dio.delete(
        AppConstants.baseUrl + url,
      );

      // Process and return the response data.
      responseJson = _response(response);
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  /// Processes the HTTP [response] based on the status code.
  ///
  /// Returns the response data if the status code indicates success (200, 201).
  /// Throws custom exceptions for various error status codes:
  /// - 400: [BadRequestException]
  /// - 401: [UnauthorizedException]
  /// - 404: [NotFoundException]
  /// - 500: [ServerException]
  /// - Default: [NetworkException]
  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException("Bad Request Error");
      case 401:
        throw UnauthorizedException("Unauthorized Request Error");
      case 404:
        throw NotFoundException("Not Found Exception");
      case 500:
        throw ServerException("Server Error");
      default:
        throw NetworkException("Network Error");
    }
  }
}
