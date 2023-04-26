import 'dart:async';

/// [CookieService] is a service for handling headers and cookies if needed.
class CookieService {
  String? _cookie;
  Map<String, String> defaultHeader = {'Content-type': 'application/json'};

  Future<Map<String, String>> header({
    bool withContentType = false,
    bool withContentTypeMultiPart = false,
  }) async {
    var header = <String, String>{};

    if (_cookie != null) {
      header.addAll({"cookie": _cookie!});
    } else {
      if (await successfullyFetchedCookie()) {
        header.addAll({"cookie": _cookie!});
      }
    }
    if (withContentType) {
      header['Content-Type'] = 'application/json';
    } else if (withContentTypeMultiPart) {
      header['Content-Type'] = 'multipart/form-data';

      /// [token] is the place of your token, and you can add other headers
      header['Authorization'] = 'Bearer [token]';
      header['Accept'] = 'application/json';
    }
    return header;
  }

  Future<bool> successfullyFetchedCookie() async {
    return _cookie != null;
  }
}
