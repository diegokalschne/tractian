import '../../interfaces/ilocations.dart';
import '../../models/assets/asset_model.dart';
import '../../repositories/locations/locations_repository.dart';

class LocationsController implements ILocations {
  @override
  Future<List<LocationModel>> fetchLocations(String companyId) async {
    final response = await LocationsRepository.fetchLocations(companyId);

    return response.map((e) => LocationModel.fromJson(e)).toList();
  }
}
