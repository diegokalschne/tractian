// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TreeStore on _TreeStore, Store {
  Computed<List<TreeModel>>? _$treeListComputed;

  @override
  List<TreeModel> get treeList =>
      (_$treeListComputed ??= Computed<List<TreeModel>>(() => super.treeList,
              name: '_TreeStore.treeList'))
          .value;

  late final _$_treeListAtom =
      Atom(name: '_TreeStore._treeList', context: context);

  @override
  ObservableList<TreeModel> get _treeList {
    _$_treeListAtom.reportRead();
    return super._treeList;
  }

  @override
  set _treeList(ObservableList<TreeModel> value) {
    _$_treeListAtom.reportWrite(value, super._treeList, () {
      super._treeList = value;
    });
  }

  late final _$loadingAtom = Atom(name: '_TreeStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_TreeStoreActionController =
      ActionController(name: '_TreeStore', context: context);

  @override
  void setLoading({required bool value}) {
    final _$actionInfo =
        _$_TreeStoreActionController.startAction(name: '_TreeStore.setLoading');
    try {
      return super.setLoading(value: value);
    } finally {
      _$_TreeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buildTree(List<AssetLocationBaseModel> items) {
    final _$actionInfo =
        _$_TreeStoreActionController.startAction(name: '_TreeStore.buildTree');
    try {
      return super.buildTree(items);
    } finally {
      _$_TreeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
treeList: ${treeList}
    ''';
  }
}
