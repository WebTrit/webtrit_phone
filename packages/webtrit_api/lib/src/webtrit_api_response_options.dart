enum ResponseType { json, bytes, raw }

class ResponseOptions {
  final ResponseType responseType;

  const ResponseOptions({this.responseType = ResponseType.json});
}
