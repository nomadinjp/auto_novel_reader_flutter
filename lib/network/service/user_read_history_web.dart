part of 'service.dart';

@ChopperApi(baseUrl: '/user/read-history')
abstract class UserReadHistoryWebService extends ChopperService {
  @GET(path: '')
  Future<Response> _getList(@Query() int page, @Query() int pageSize);
  Future<Response?> getList({
    int page = 0,
    int pageSize = 16,
  }) =>
      tokenRequest(() => _getList(page, pageSize));

  @DELETE(path: '')
  Future<Response> _delHistory();
  Future<Response?> delHistory() => tokenRequest(() => _delHistory());

  @GET(path: '/paused')
  Future<Response> _getPaused();
  Future<Response?> getPaused() => tokenRequest(() => _getPaused());

  @PUT(path: '/paused')
  Future<Response> _putPaused();
  Future<Response?> putPaused() => tokenRequest(() => _putPaused());

  @DELETE(path: '/paused')
  Future<Response> _delPaused();
  Future<Response?> delPaused() => tokenRequest(() => _delPaused());

  @PUT(path: '/{providerId}/{novelId}')
  Future<Response> _putNovelId(
      @Path() String providerId, @Path() String novelId, @Body() body);
  Future<Response?> putNovelId(
          String providerId, String novelId, String chapterId) =>
      tokenRequest(() => _putNovelId(
            providerId,
            novelId,
            chapterId,
          ));

  @DELETE(path: '/{providerId}/{novelId}')
  Future<Response> _delNovelId(
      @Path() String providerId, @Path() String novelId);
  Future<Response?> delNovelId(String providerId, String novelId) =>
      tokenRequest(() => _delNovelId(providerId, novelId));

  static UserReadHistoryWebService create([ChopperClient? client]) =>
      _$UserReadHistoryWebService(client);
}
