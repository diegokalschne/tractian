// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_locations_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsLocationsStore on _AssetsLocationsStoreBase, Store {
  Computed<List<AssetLocationBaseModel>>? _$assetsAndLocationsComputed;

  @override
  List<AssetLocationBaseModel> get assetsAndLocations =>
      (_$assetsAndLocationsComputed ??= Computed<List<AssetLocationBaseModel>>(
              () => super.assetsAndLocations,
              name: '_AssetsLocationsStoreBase.assetsAndLocations'))
          .value;

  late final _$_assetsAndLocationsAtom = Atom(
      name: '_AssetsLocationsStoreBase._assetsAndLocations', context: context);

  @override
  ObservableList<AssetLocationBaseModel> get _assetsAndLocations {
    _$_assetsAndLocationsAtom.reportRead();
    return super._assetsAndLocations;
  }

  @override
  set _assetsAndLocations(ObservableList<AssetLocationBaseModel> value) {
    _$_assetsAndLocationsAtom.reportWrite(value, super._assetsAndLocations, () {
      super._assetsAndLocations = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_AssetsLocationsStoreBase.loading', context: context);

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

  late final _$hasErrorAtom =
      Atom(name: '_AssetsLocationsStoreBase.hasError', context: context);

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  late final _$hasInternetAtom =
      Atom(name: '_AssetsLocationsStoreBase.hasInternet', context: context);

  @override
  bool get hasInternet {
    _$hasInternetAtom.reportRead();
    return super.hasInternet;
  }

  @override
  set hasInternet(bool value) {
    _$hasInternetAtom.reportWrite(value, super.hasInternet, () {
      super.hasInternet = value;
    });
  }

  late final _$_AssetsLocationsStoreBaseActionController =
      ActionController(name: '_AssetsLocationsStoreBase', context: context);

  @override
  void setAssetsAndLocations(List<AssetLocationBaseModel> items) {
    final _$actionInfo = _$_AssetsLocationsStoreBaseActionController
        .startAction(name: '_AssetsLocationsStoreBase.setAssetsAndLocations');
    try {
      return super.setAssetsAndLocations(items);
    } finally {
      _$_AssetsLocationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading({required bool value}) {
    final _$actionInfo = _$_AssetsLocationsStoreBaseActionController
        .startAction(name: '_AssetsLocationsStoreBase.setLoading');
    try {
      return super.setLoading(value: value);
    } finally {
      _$_AssetsLocationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasError({required bool value}) {
    final _$actionInfo = _$_AssetsLocationsStoreBaseActionController
        .startAction(name: '_AssetsLocationsStoreBase.setHasError');
    try {
      return super.setHasError(value: value);
    } finally {
      _$_AssetsLocationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasInternet({required bool value}) {
    final _$actionInfo = _$_AssetsLocationsStoreBaseActionController
        .startAction(name: '_AssetsLocationsStoreBase.setHasInternet');
    try {
      return super.setHasInternet(value: value);
    } finally {
      _$_AssetsLocationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
hasError: ${hasError},
hasInternet: ${hasInternet},
assetsAndLocations: ${assetsAndLocations}
    ''';
  }
}
