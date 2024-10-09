import '../../services/http_service.dart';

class LocationsRepository {
  static Future<List> fetchLocations(String companyId) async {
    return await HttpService.get(route: '/companies/$companyId/locations');
  }
}
