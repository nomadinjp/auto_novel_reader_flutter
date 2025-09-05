import 'dart:convert';
import 'package:http/http.dart' as http;

class SimpleClient {
  final String baseUrl;

  SimpleClient({this.baseUrl = ''});

  Future<http.Response> _sendRestRequest({
    required String url,
    dynamic data,
    Map<String, String>? params,
    required String method,
    Map<String, String>? headers,
  }) async {
    // 拼接 query 参数
    final uri = Uri.parse(baseUrl + url).replace(queryParameters: params);

    final request = http.Request(method, uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    // GET/DELETE 不放 body，POST/PUT 才放
    if (method != 'GET' && method != 'DELETE' && data != null) {
      if (data is String) {
        request.body = data;
      } else {
        request.body = jsonEncode(data);
        request.headers['Content-Type'] = 'application/json';
      }
    }

    return await http.Response.fromStream(await request.send());
  }

  Future<http.Response> get({
    required String url,
    Map<String, String>? params,
    Map<String, String>? headers,
  }) =>
      _sendRestRequest(
        url: url,
        params: params,
        method: 'GET',
        headers: headers,
      );

  Future<http.Response> post({
    required String url,
    dynamic data,
    Map<String, String>? headers,
    Map<String, String>? params,
  }) =>
      _sendRestRequest(
        url: url,
        data: data,
        method: 'POST',
        params: params,
        headers: headers,
      );

  Future<http.Response> put({
    required String url,
    dynamic data,
    Map<String, String>? headers,
  }) =>
      _sendRestRequest(
        url: url,
        data: data,
        method: 'PUT',
        headers: headers,
      );

  Future<http.Response> delete({
    required String url,
    Map<String, String>? params,
    Map<String, String>? headers,
  }) =>
      _sendRestRequest(
        url: url,
        params: params,
        method: 'DELETE',
        headers: headers,
      );
}
