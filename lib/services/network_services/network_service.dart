part of 'index.dart';

/// A base class for a network clients.
abstract class BaseNetworkService {
  Future get({required String url});

  Future post({required String url, required final dynamic data});

  Future patch({required String url, final dynamic data});

  Future delete({required String url});
}

/// A network service class for making HTTP requests.
class NetworkService implements BaseNetworkService {
  final String baseUrl = 'https://api.github.com';
  final dio = Dio();

  NetworkService();

  @override
  Future get({required String url}) async {
    final dynamic responseJson;
    try {
      final response = await dio.get(
        baseUrl + url,
      );

      responseJson = _response(response);

    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  @override
  Future post({
    required String url,
    required data,
  }) async {
    final dynamic responseJson;
    try {
      final response = await dio.post(baseUrl + url, data: jsonEncode(data));
      responseJson = _response(response);
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  @override
  Future patch({required String url, data}) async {
    final dynamic responseJson;
    try {
      final response = await dio.patch(baseUrl + url, data: jsonEncode(data));
      responseJson = _response(response);
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  @override
  Future delete({required String url}) async {
    final dynamic responseJson;
    try {
      final response = await dio.delete(
        baseUrl + url,
      );
      responseJson = _response(response);
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

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
        throw NotFoundException("Not Found Exception ");
      case 500:
        throw ServerException("Server Error");
      default:
        throw NetworkException("Network Error");
    }
  }
}
