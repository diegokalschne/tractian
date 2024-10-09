import '../../services/http_service.dart';

class CompaniesRepository {
  static Future<List> fetchCompanies() async {
    return await HttpService.get(route: '/companies');
  }
}
