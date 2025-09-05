import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env')
abstract class Env {
  @EnviedField(varName: 'TEST_USERNAME', defaultValue: 'no_username')
  static const String username = _Env.username;
  @EnviedField(varName: 'TEST_PASSWORD', defaultValue: 'no_password')
  static const String password = _Env.password;
}
