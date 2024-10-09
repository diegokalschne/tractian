import 'package:mobx/mobx.dart';

import '../../controllers/assets/assets_controller.dart';
import '../../controllers/locations/locations_controller.dart';
import '../../models/assets/asset_model.dart';
import '../../models/company/company_model.dart';
import '../../utils/function_utils.dart';

part 'assets_locations_store.g.dart';

class AssetsLocationsStore = _AssetsLocationsStoreBase with _$AssetsLocationsStore;

abstract class _AssetsLocationsStoreBase with Store {
  @observable
  ObservableList<AssetLocationBaseModel> _assetsAndLocations = ObservableList();

  @observable
  bool loading = false;

  @observable
  bool hasError = false;

  @observable
  bool hasInternet = true;

  @computed
  List<AssetLocationBaseModel> get assetsAndLocations => [..._assetsAndLocations];

  @action
  void setAssetsAndLocations(List<AssetLocationBaseModel> items) {
    _assetsAndLocations = items.asObservable();
  }

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

  Future<void> fetchAssetsAndLocations(CompanyModel company) async {
    try {
      setLoading(value: true);

      final registers = await Future.wait([
        AssetsController().fetchAssets(company.id),
        LocationsController().fetchLocations(company.id),
      ]);

      setAssetsAndLocations([...registers[0], ...registers[1]]);
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
