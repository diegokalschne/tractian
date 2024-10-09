import '../../services/http_service.dart';

class AssetsRepository {
  static Future<List> fetchAssets(String companyId) async {
    return await HttpService.get(route: '/companies/$companyId/assets');
  }
}
