abstract class NetworkException implements Exception {
  @override
  String toString() => "Network Exception";
}

class ConnectionException implements NetworkException {}

class RequestFailedExcetion implements NetworkException {
  final String message;

  RequestFailedExcetion(this.message);
  @override
  String toString() => message;
}
