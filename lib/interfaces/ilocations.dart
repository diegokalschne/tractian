import '../models/assets/asset_model.dart';

abstract class ILocations {
  Future<List<LocationModel>> fetchLocations(String companyId);
}
