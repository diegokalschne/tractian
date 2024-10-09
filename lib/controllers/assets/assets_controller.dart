import '../../interfaces/iassets.dart';
import '../../models/assets/asset_model.dart';
import '../../repositories/assets/assets_repository.dart';

class AssetsController implements IAssets {
  @override
  Future<List<AssetLocationBaseModel>> fetchAssets(String companyId) async {
    final response = await AssetsRepository.fetchAssets(companyId);

    return response.map((e) => AssetLocationBaseModel.fromJson(e)).toList();
  }
}
