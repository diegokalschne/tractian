import '../models/company/company_model.dart';

abstract class ICompanies {
  Future<List<CompanyModel>> fetchCompanies();
}
