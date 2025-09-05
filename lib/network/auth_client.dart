import 'package:auto_novel_reader_flutter/network/simple_client.dart';
import 'package:http/http.dart' show Response;

class AuthClient {
  final String baseUrl;
  late final SimpleClient client;

  AuthClient({required this.baseUrl}) {
    client = SimpleClient(baseUrl: '$baseUrl/v1/auth');
  }

  Future<Response> login(dynamic body) => client.post(
        url: '/login',
        data: body,
        headers: {'Content-Type': 'application/json'},
      );

  // NEED_TEST
  Future<Response> refresh(String token) => client.post(
        url: '/refresh',
        params: {'app': 'n'},
        headers: {'Cookie': 'refresh-token=$token'},
      );

  // NEED_TEST
  Future<Response> register(dynamic body) =>
      client.post(url: '/register', data: body);

  // NEED_TEST
  Future<Response> verifyEmail(dynamic body) =>
      client.post(url: '/verify-email', data: body);

  // NEED_TEST
  Future<Response> resetPassword(dynamic body) =>
      client.post(url: '/reset-password', data: body);
}
