part of 'service.dart';

@ChopperApi(baseUrl: '/auth')
@Deprecated('Use AuthClient instead')
abstract class AuthService extends ChopperService {
  @POST(path: '/sign-in')
  Future<Response> postSignIn(@Body() JsonBody body);

  @POST(path: '/sign-up')
  Future<Response> postSignUp(@Body() JsonBody body);

  @GET(path: '/renew')
  Future<Response> _getRenew();
  Future<Response?> getRenew() => tokenRequest(() => _getRenew());

  @POST(path: '/verify-email')
  Future<Response> postVerifyEmail(@Query() String email);

  @POST(path: '/reset-password-email')
  Future<Response> postResetPasswordEmail();

  @POST(path: '/reset-password')
  Future<Response> postResetPassword();

  static AuthService create([ChopperClient? client]) => _$AuthService(client);
}
