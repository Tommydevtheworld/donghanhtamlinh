class AppException implements Exception {
  final String message;
  final String? prefix;
  final String? url;

  AppException([this.message = 'An unknown error occurred', this.prefix, this.url]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message ?? 'Error during communication', 'Communication error: ', url);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message ?? 'Invalid request', 'Invalid Request: ', url);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message, String? url])
      : super(message ?? 'Unauthorized request', 'Unauthorized: ', url);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(message ?? 'Requested resource not found', 'Not found: ', url);
}
