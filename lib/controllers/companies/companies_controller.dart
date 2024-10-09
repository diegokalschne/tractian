import '../../interfaces/icompanies.dart';
import '../../models/company/company_model.dart';
import '../../repositories/companies/companies_repository.dart';

class CompaniesController implements ICompanies {
  @override
  Future<List<CompanyModel>> fetchCompanies() async {
    final response = await CompaniesRepository.fetchCompanies();

    return response.map((e) => CompanyModel.fromJson(e)).toList();
  }
}
