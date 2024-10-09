import '../models/assets/asset_model.dart';

abstract class IAssets {
  Future<List<AssetLocationBaseModel>> fetchAssets(String companyId);
}
