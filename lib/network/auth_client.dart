import 'package:auto_novel_reader_flutter/network/simple_client.dart';
import 'package:auto_novel_reader_flutter/util/client_util.dart';
import 'package:http/http.dart' show Response;

final authClient = _AuthClient();

class _AuthClient {
  late final SimpleClient client = SimpleClient();

  Future<Response> login(dynamic body) => client.post(
        url: 'https://${configCubit.state.authHost}/api/v1/auth/login',
        data: body,
        headers: {'Content-Type': 'application/json'},
      );

  Future<Response> refresh() => client.post(
        url: 'https://${configCubit.state.authHost}/api/v1/auth/refresh',
        params: {'app': 'n'},
        headers: {'Cookie': 'refresh-token=${userCubit.state.refreshToken}'},
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
