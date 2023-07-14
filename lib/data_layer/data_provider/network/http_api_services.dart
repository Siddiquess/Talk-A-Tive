abstract class HttpApiServices {
  Future<dynamic> httpGetMethod({
    required String url,
    bool haveHeader = false,
  });
  Future<dynamic> httpPostethod({
    required String url,
    required Map body,
    bool haveHeader = false,
  });
}
