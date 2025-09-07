import 'package:auto_novel_reader_flutter/network/api_client.dart';
import 'package:auto_novel_reader_flutter/network/auth_client.dart';
import 'package:auto_novel_reader_flutter/util/client_util.dart';
import 'package:auto_novel_reader_flutter/util/error_logger.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';
part 'user_cubit.g.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(const UserState.initial());

  Future<bool> login(String emailOrUsername, String password) async {
    try {
      final loginResponse = await authClient.login({
        'username': emailOrUsername,
        'password': password,
        'app': 'n',
      });

      if (loginResponse.statusCode == 502) {
        Fluttertoast.showToast(msg: '服务器维护中');
        return false;
      }
      if (loginResponse.statusCode != 200) {
        showErrorToast('登录失败, ${loginResponse.statusCode}');
        return false;
      }

      final token = loginResponse.body;
      final refreshToken =
          extractRefreshToken(loginResponse.headers['set-cookie'] ?? '');
      return afterLogin(
        token: token,
        refreshToken: refreshToken,
        emailOrUsername: emailOrUsername,
        password: password,
      );
    } catch (e, stackTrace) {
      errorLogger.logError(e, stackTrace);
      showErrorToast(
        '登录失败$e',
      );
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String username,
    required String password,
    required String emailCode,
  }) async {
    try {
      final response = await apiClient.authService.postSignUp({
        'email': email,
        'username': username,
        'password': password,
        'emailCode': emailCode,
      });
      return afterLogin(
        token: response.body,
        // TODO
        refreshToken: '',
        emailOrUsername: email,
        password: password,
      );
    } catch (e, stackTrace) {
      errorLogger.logError(e, stackTrace);
      showErrorToast(
        '注册失败$e',
      );
      return false;
    }
  }

  bool afterLogin({
    required String? token,
    required String? refreshToken,
    required String emailOrUsername,
    required String password,
  }) {
    if (token == null || token.isEmpty) {
      showErrorToast('登录失败, 令牌为空');
      return false;
    }
    try {
      final jwt = JWT.decode(token).payload;
      emit(state.copyWith(
        username: jwt['sub'],
        role: jwt['role'],
        createAt: jwt['crat'],
        emailOrUsername: emailOrUsername,
        password: password,
        autoSignIn: true,
        token: token,
        refreshToken: refreshToken,
        signInTime: DateTime.now(),
      ));
    } catch (e, stackTrace) {
      errorLogger.logError(e, stackTrace);
      return false;
    }

    favoredCubit.init();
    return true;
  }

  /// 在 apiClient 初始化完成后调用
  Future<void> activateAuth(BuildContext context) async {
    if (state.token == null) return;
    await refreshToken();

    final signInTime = state.signInTime;
    final timeSpan = (signInTime?.difference(DateTime.now()).inDays.abs() ?? 0);
    if (signInTime == null || timeSpan >= 7) {
      if (context.mounted) {
        await _autoSignIn(context);
      }
    } else if (timeSpan >= 6) {
      await refreshToken();
    }
    talker.debug('test finish');
  }

  Future<void> _autoSignIn(BuildContext context) async {
    final signInSucceed = await login(
      state.emailOrUsername,
      state.password,
    );
    if (signInSucceed) return;
    showErrorToast('自动登录失败, 请尝试手动登录');
    emit(const UserState.initial());
  }

  Future<void> refreshToken() async {
    try {
      final renewResponse = await authClient.refresh();
      final token = renewResponse.body;
      if (token.isEmpty) return;
      emit(state.copyWith(
        token: token,
        signInTime: DateTime.now(),
      ));
    } catch (e, stackTrace) {
      showErrorToast('自动登录失败, 请尝试手动登录');
      errorLogger.logError(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    emit(const UserState.initial());
  }

  bool get isSignIn => state.token != null;
  bool get isOldAss {
    final createAt = state.createAt;
    if (createAt == null) return false;
    final createTime = DateTime.fromMillisecondsSinceEpoch(createAt);
    return DateTime.now().difference(createTime).inDays >= 30;
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) => UserState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(UserState state) => state.toJson();
}
