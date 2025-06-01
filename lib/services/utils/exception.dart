class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

class NotFoundException extends ApiException {
  NotFoundException() : super('Resource not found.');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super('Unauthorized.');
}

class ForbiddenException extends ApiException {
  ForbiddenException() : super('Forbidden.');
}

class BadRequestException extends ApiException {
  BadRequestException() : super('Bad request.');
}

class ConflictException extends ApiException {
  ConflictException() : super('Conflict - Resource already exists.');
}

class TooManyRequestsException extends ApiException {
  TooManyRequestsException() : super('Too Many Requests - Rate limit exceeded.');
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException() : super('Service temporarily unavailable.');
}

dynamic handleDioStatusCode(int statusCode) {
  
    switch (statusCode) {
      case 400:
        throw BadRequestException();
      case 403:
        throw ForbiddenException();
      case 404:
        return NotFoundException();
      case 409:
        throw ConflictException();
      case 429:
        throw TooManyRequestsException();
      case 401:
        throw UnauthorizedException();
      default:
        throw ApiException('API Error: $statusCode');
    }
  }
