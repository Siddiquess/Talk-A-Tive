abstract class HttpApiServices {
  Future<dynamic> httpGetMethod({
    required String url,
    String? headers,
  });
  Future<dynamic> httpPostethod({
    required String url,
    required Map body,
    String? headers,
  });
}
