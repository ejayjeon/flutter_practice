class DioException implements Exception {
  final String message;
  final int statusCode;
  final String identifier;

  DioException({
    this.message = "",
    this.statusCode = 0,
    this.identifier = "",
  });

  @override
  String toString() =>
      '[statusCode] $statusCode\nmessage: $message\nidentifier: $identifier';
}
