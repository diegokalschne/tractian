import '../assets/asset_model.dart';

class TreeModel {
  TreeModel({required this.node});

  late final AssetLocationBaseModel node;
  List<TreeModel> leaves = [];
  int _countLeaves = 0;

  int countLeaves() {
    if (_countLeaves != 0) return _countLeaves;

    int count = leaves.length;
    for (var leaf in leaves) {
      count += leaf.countLeaves();
    }

    _countLeaves = count;

    return count;
  }

  TreeModel? filterTree(bool Function(AssetLocationBaseModel) condition) {
    bool nodeMatches = condition(node);

    Iterable<TreeModel?> filteredLeaves = leaves.map((leaf) => leaf.filterTree(condition)).where((e) => e != null);

    if (nodeMatches || filteredLeaves.isNotEmpty) {
      return TreeModel(node: node)..leaves = filteredLeaves.cast<TreeModel>().toList();
    }

    return null;
  }
}
