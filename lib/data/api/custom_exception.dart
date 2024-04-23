class ResultException implements Exception {
  final String message;

  ResultException(this.message); // Pass your message in constructor.

  @override
  String toString() {
    return message;
  }
}
