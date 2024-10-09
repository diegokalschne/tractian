import 'dart:isolate';

import 'package:diacritic/diacritic.dart';
import 'package:mobx/mobx.dart';

import '../../models/assets/asset_model.dart';
import '../../models/filters/assets_filter.dart';
import '../../models/tree/tree_model.dart';
import '../../services/service_locator.dart';
import '../../utils/function_utils.dart';

part 'tree_store.g.dart';

class TreeStore = _TreeStore with _$TreeStore;

abstract class _TreeStore with Store {
  @observable
  ObservableList<TreeModel> _treeList = ObservableList();

  @observable
  bool loading = true;

  final Map<int, List<TreeModel>> _cacheSearch = {};

  @computed
  List<TreeModel> get treeList {
    final filters = locator<AssetsFilter>();
    final hasSearch = !isNullOrEmpty(filters.where);

    int cacheKey = 0;
    if (filters.energySensor) cacheKey += 1;
    if (filters.criticalStatus) cacheKey += 2;

    List<TreeModel> availables;

    if (cacheKey > 0) {
      final cachedResult = _cacheSearch[cacheKey];
      if (cachedResult != null) {
        availables = cachedResult;
      } else {
        availables = _filterTreeModels();
        _cacheSearch[cacheKey] = availables;
      }
    } else {
      availables = [..._treeList];
    }

    if (hasSearch) {
      final filteredListTree = availables.map((tree) => tree.filterTree((node) => removeDiacritics(node.name).toLowerCase().contains(removeDiacritics(filters.where!).toLowerCase())));

      availables = filteredListTree.where((filteredTree) => filteredTree != null).cast<TreeModel>().toList();
    }

    return availables;
  }

  List<TreeModel> _filterTreeModels() {
    final filters = locator<AssetsFilter>();

    bool filterCondition(AssetLocationBaseModel node) {
      if (node is! ComponentModel) return false;

      final statusMatch = !filters.criticalStatus || node.status == 'alert';
      final sensorMatch = !filters.energySensor || node.sensorType == 'energy';

      return statusMatch && sensorMatch;
    }

    final filteredListTree = _treeList.map((tree) => tree.filterTree(filterCondition)).toList();

    return filteredListTree.where((filteredTree) => filteredTree != null).cast<TreeModel>().toList();
  }

  @action
  void setLoading({required bool value}) {
    loading = value;
  }

  @action
  void buildTree(List<AssetLocationBaseModel> items) {
    setLoading(value: true);

    _cacheSearch.clear();

    final receivePort = ReceivePort();

    Isolate.spawn(_buildTreeIsolate, [receivePort.sendPort, items]);

    receivePort.listen(
      (data) {
        if (data is List<TreeModel>) {
          _treeList = data.asObservable();
        }

        setLoading(value: false);
        receivePort.close();
      },
      onError: (_) {
        setLoading(value: false);
        receivePort.close();
      },
      cancelOnError: true,
    );
  }
}

void _buildTreeIsolate(List args) {
  final port = args[0] as SendPort;
  final items = args[1] as List<AssetLocationBaseModel>;
  final treeList = <TreeModel>[];

  final baseNodes = items.where((e) => (e is LocationModel && e.parentId == null) || (e is AssetModel && e.locationId == null && e.parentId == null) || (e is ComponentModel && e.locationId == null && e.parentId == null)).toList();

  Map<String, String> treeItemsIds = {};

  TreeModel getLeaves(AssetLocationBaseModel item) {
    final node = TreeModel(node: item);
    List<AssetLocationBaseModel> leaves = [];

    if (treeItemsIds.containsKey(item.id)) {
      return node;
    }

    treeItemsIds.addAll({item.id: item.name});

    if (item is LocationModel) {
      leaves = items.where((e) => (e is AssetModel && e.locationId == item.id) || (e is ComponentModel && e.locationId == item.id) || (e is LocationModel && e.parentId == item.id)).toList();
    } else if (item is AssetModel) {
      leaves = items.where((e) => (e is ComponentModel && e.parentId == item.id) || (e is AssetModel && e.parentId == item.id)).toList();
    } else if (item is ComponentModel) {
      leaves = items.where((e) => (e is LocationModel && e.id == item.locationId) || (e is AssetModel && e.parentId == item.id) || (e is ComponentModel && e.parentId == item.id)).toList();
    }

    if (leaves.isNotEmpty) {
      for (var leaf in leaves) {
        final internalLeaves = getLeaves(leaf);
        node.leaves.add(internalLeaves);
      }
    }

    return node;
  }

  for (var node in baseNodes) {
    treeList.add(getLeaves(node));
    treeItemsIds = {};
  }

  treeList.sort((a, b) {
    return b.countLeaves().compareTo(a.countLeaves());
  });

  port.send(treeList);
}
