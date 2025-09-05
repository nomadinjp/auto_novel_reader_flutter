import 'package:auto_novel_reader_flutter/env/env.dart';
import 'package:auto_novel_reader_flutter/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:auto_novel_reader_flutter/network/auth_client.dart';

final talker = Talker();

// NEED TEST
void main() {
  test('login then refresh token', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await initHydratedStorage();
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
    final refreshRes = await authClient.refresh();

    // 验证刷新成功

    final newToken = refreshRes.body;
    expect(refreshRes.statusCode, 200);
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
