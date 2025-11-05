class StoreInfoExtractorException implements Exception {}

class StoreInfoExtractorResponseError implements StoreInfoExtractorException {
  StoreInfoExtractorResponseError({
    required this.statusCode,
    this.reasonPhrase,
  });

  final int statusCode;
  final String? reasonPhrase;

  @override
  String toString() {
    final sb = StringBuffer('StoreInfoExtractorResponseError(');
    sb.write('$statusCode');
    final reasonPhrase = this.reasonPhrase;
    if (reasonPhrase != null) {
      sb.write(', $reasonPhrase');
    }
    sb.write(')');
    return sb.toString();
  }
}

class StoreInfoExtractorResponseFormatException
    implements StoreInfoExtractorException {
  StoreInfoExtractorResponseFormatException({
    required this.sourceError,
  });

  final Object sourceError;

  @override
  String toString() {
    return 'StoreInfoExtractorResponseFormatException($sourceError)';
  }
}
