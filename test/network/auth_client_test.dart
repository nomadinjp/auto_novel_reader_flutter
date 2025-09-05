import 'package:auto_novel_reader_flutter/env/env.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test/test.dart';

import 'package:auto_novel_reader_flutter/network/auth_client.dart';

final talker = Talker();
void main() {
  late AuthClient authClient;

  setUp(() {
    authClient = AuthClient(baseUrl: 'https://auth.novelia.cc/api');
  });

  test('login then refresh token', () async {
    // 1️⃣ login
    final response = await authClient.login({
      "username": Env.username,
      "password": Env.password,
      'app': 'n',
    });

    final token = response.body;
    final refreshToken =
        extractRefreshToken(response.headers['set-cookie'] ?? '');
    expect(response.statusCode, 200);
    expect(token, isNotNull);
    expect(refreshToken, isNotNull);

    talker.info(token);

    // 2️⃣ refresh token
    final refreshRes = await authClient.refresh(
      refreshToken!, // cookie
    );

    // 验证刷新成功

    final newToken = refreshRes.body;
    expect(refreshRes.statusCode, 200);
    expect(newToken, isNotNull);

    talker.info(newToken);
  });

  test('login with valid credentials should return 200', () async {
    final response = await authClient.login({
      "username": Env.username,
      "password": Env.password,
      'app': 'n',
    });

    if (response.statusCode != 200) {
      talker.error(response.body);
    }

    talker.info(response.body);
    final refreshToken = response.headers['set-cookie'];
    talker.info(refreshToken);
    expect(response.statusCode, 200);
  });

  test('refresh token should return 200', () async {
    const refreshToken = "";

    final response = await authClient.refresh(refreshToken);
    expect(response.statusCode, 200);
    final newToken = response.body;
    expect(newToken, isNotNull);
    talker.info(newToken);
  });
}

String? extractRefreshToken(String cookie) {
  // 正则匹配 refresh-token=xxx; 形式
  final regex = RegExp(r'refresh-token=([^;]+)');
  final match = regex.firstMatch(cookie);
  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }
  return null;
}
