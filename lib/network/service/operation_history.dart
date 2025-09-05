part of 'service.dart';

@ChopperApi(baseUrl: '/operation-history')
abstract class OperationHistoryService extends ChopperService {
  @GET(path: '')
  Future<Response> getOperationHistory();

  @GET(path: '/toc-merge/')
  Future<Response> getTocList();

  @DELETE(path: '/{id}')
  Future<Response> _delId(@Path() String id);
  Future<Response?> delId(@Path() String id) => tokenRequest(() => _delId(id));

  @DELETE(path: '/toc-merge/{id}')
  Future<Response> _delTocId(@Path() String id);
  Future<Response?> delTocId(@Path() String id) =>
      tokenRequest(() => _delTocId(id));

  static OperationHistoryService create([ChopperClient? client]) =>
      _$OperationHistoryService(client);
}
