abstract class NetworkException implements Exception {
  @override
  String toString() => "Network Exception";
}

class ConnectionException implements NetworkException {}
