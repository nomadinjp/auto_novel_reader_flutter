part of 'service.dart';

@ChopperApi(baseUrl: '/user')
abstract class UserService extends ChopperService {
  @GET(path: '')
  Future<Response> _getUser();
  Future<Response?> getUser() => tokenRequest(() => _getUser());

  @GET(path: '/favored')
  Future<Response> _getFavored();
  Future<Response?> getFavored() => tokenRequest(() => _getFavored());

  static UserService create([ChopperClient? client]) => _$UserService(client);
}
