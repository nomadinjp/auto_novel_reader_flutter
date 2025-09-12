part of 'service.dart';

@ChopperApi(baseUrl: '/article')
abstract class ArticleService extends ChopperService {
  @GET(path: '')
  Future<Response> getArticleList();

  @GET(path: '/{id}')
  Future<Response> getId(@Path() String id);

  @POST(path: '')
  Future<Response> _postArticle();
  Future<Response?> postArticle() => tokenRequest(() => _postArticle());

  @PUT(path: '/{id}')
  Future<Response> _putId(@Path() String id);
  Future<Response?> putId(String id) => tokenRequest(() => _putId(id));

  @DELETE(path: '/{id}')
  Future<Response> _delId(@Path() String id);
  Future<Response?> delId(String id) => tokenRequest(() => _delId(id));

  @PUT(path: '/{id}/locked')
  Future<Response> _putIdLocked(@Path() String id);
  Future<Response?> putIdLocked(String id) =>
      tokenRequest(() => _putIdLocked(id));

  @DELETE(path: '/{id}/locked')
  Future<Response> _delIdLocked(@Path() String id);
  Future<Response?> delIdLocked(String id) =>
      tokenRequest(() => _delIdLocked(id));

  @PUT(path: '/{id}/pinned')
  Future<Response> _putIdPinned(@Path() String id);
  Future<Response?> putIdPinned(String id) =>
      tokenRequest(() => _putIdPinned(id));

  @DELETE(path: '/{id}/pinned')
  Future<Response> _delPinned(@Path() String id);
  Future<Response?> delPinned(String id) => tokenRequest(() => _delPinned(id));

  @PUT(path: '/{id}/hidden')
  Future<Response> _putIdHidden(@Path() String id);
  Future<Response?> putIdHidden(String id) =>
      tokenRequest(() => _putIdHidden(id));

  @DELETE(path: '/{id}/hidden')
  Future<Response> _delIdHidden(@Path() String id);
  Future<Response?> delIdHidden(String id) =>
      tokenRequest(() => _delIdHidden(id));

  static ArticleService create([ChopperClient? client]) =>
      _$ArticleService(client);
}
