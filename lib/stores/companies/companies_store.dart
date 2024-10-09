import 'package:mobx/mobx.dart';

import '../../constants/constants.dart';
import '../../controllers/companies/companies_controller.dart';
import '../../models/company/company_model.dart';
import '../../services/cache_service.dart';
import '../../services/dialog_service.dart';
import '../../utils/function_utils.dart';

part 'companies_store.g.dart';

class CompaniesStore = _CompaniesStore with _$CompaniesStore;

abstract class _CompaniesStore with Store {
  @observable
  ObservableList<CompanyModel> _companies = ObservableList();

  @observable
  bool loading = false;

  @observable
  bool hasError = false;

  @observable
  bool hasInternet = true;

  @computed
  List<CompanyModel> get companies => [..._companies];

  @action
  void setLoading({required bool value}) {
    loading = value;

    if (value) {
      hasError = false;
      hasInternet = true;
    }
  }

  @action
  void setHasError({required bool value}) {
    hasError = value;
  }

  @action
  void setHasInternet({required bool value}) {
    hasInternet = value;
  }

  @action
  void setCompanies(List<CompanyModel> companies, {bool saveCache = true}) {
    _companies = companies.asObservable();

    if (saveCache) {
      CacheService.storeCache(CacheKeys.CACHE_COMPANY, companies);
    }
  }

  Future<void> fetchCompanies({bool forceSynk = false}) async {
    try {
      setLoading(value: true);

      if (await CacheService.canGetCacheInfo(CacheKeys.CACHE_COMPANY) && !forceSynk) {
        final cache = await CacheService.getCache<CompanyModel, List<CompanyModel>?>(CacheKeys.CACHE_COMPANY, CompanyModel.fromJson);

        if (cache?.isNotEmpty ?? false) {
          setCompanies(cache!, saveCache: false);
          showSnackbar('Companhias carregadas a partir de cache', seconds: 3);
          return;
        }
      }

      final companies = await CompaniesController().fetchCompanies();

      setCompanies(companies);
    } catch (err) {
      setHasError(value: true);

      if (isInternetError(err)) {
        setHasInternet(value: false);
      }
    } finally {
      setLoading(value: false);
    }
  }
}
