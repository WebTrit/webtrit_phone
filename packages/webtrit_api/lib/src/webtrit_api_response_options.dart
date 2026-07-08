enum ResponseType { json, bytes, raw }

class ResponseOptions {
  final ResponseType responseType;

  /// Marks the endpoint as optional in the adapter contract: a 404 or 501
  /// response is reported as [EndpointNotSupportedException] instead of a
  /// plain [RequestFailure].
  final bool optionalEndpoint;

  const ResponseOptions({this.responseType = ResponseType.json, this.optionalEndpoint = false});
}
