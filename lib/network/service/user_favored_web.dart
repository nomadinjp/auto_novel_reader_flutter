part of 'service.dart';

@ChopperApi(baseUrl: '/user/favored-web')
abstract class UserFavoredWebService extends ChopperService {
  @POST(path: '')
  Future<Response> _postWeb(@Body() body);
  Future<Response?> postWeb(Map<String, dynamic> body) =>
      tokenRequest(() => _postWeb(body));

  @PUT(path: '/{favoredId}')
  Future<Response> _putId(@Path() String favoredId, @Body() body);
  Future<Response?> putId(
          @Path() String favoredId, Map<String, dynamic> body) =>
      tokenRequest(() => _putId(favoredId, body));

  @DELETE(path: '/{favoredId}')
  Future<Response> _delId(@Path() String favoredId);
  Future<Response?> delId(@Path() String favoredId) =>
      tokenRequest(() => _delId(favoredId));

  @GET(path: '/{favoredId}')
  Future<Response> _getIdList(
    @Path() String favoredId,
    @Query() int page,
    @Query() int pageSize,
    @Query() String sort,
    @Query() String provider,
  );
  Future<Response?> getIdList({
    String favoredId = 'default',
    int page = 0,
    int pageSize = 8,
    String sort = 'update',
    String provider = 'kakuyomu,syosetu,novelup,hameln,pixiv,alphapolis',
  }) =>
      tokenRequest(() => _getIdList(favoredId, page, pageSize, sort, provider));

  @PUT(path: '/{favoredId}/{providerId}/{novelId}')
  Future<Response> _putNovelId(
    @Path() String favoredId,
    @Path() String providerId,
    @Path() String novelId,
  );
  Future<Response?> putNovelId(
    String providerId,
    String novelId, {
    String favoredId = 'default',
  }) =>
      tokenRequest(() => _putNovelId(favoredId, providerId, novelId));

  @DELETE(path: '/{favoredId}/{providerId}/{novelId}')
  Future<Response> _deleteNovelId(
    @Path() String favoredId,
    @Path() String providerId,
    @Path() String novelId,
  );
  Future<Response?> deleteNovelId(
    String providerId,
    String novelId, {
    String favoredId = 'default',
  }) =>
      tokenRequest(() => _deleteNovelId(favoredId, providerId, novelId));

  static UserFavoredWebService create([ChopperClient? client]) =>
      _$UserFavoredWebService(client);
}
