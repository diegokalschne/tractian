// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_filter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsFilter on _AssetsFilter, Store {
  late final _$energySensorAtom =
      Atom(name: '_AssetsFilter.energySensor', context: context);

  @override
  bool get energySensor {
    _$energySensorAtom.reportRead();
    return super.energySensor;
  }

  @override
  set energySensor(bool value) {
    _$energySensorAtom.reportWrite(value, super.energySensor, () {
      super.energySensor = value;
    });
  }

  late final _$criticalStatusAtom =
      Atom(name: '_AssetsFilter.criticalStatus', context: context);

  @override
  bool get criticalStatus {
    _$criticalStatusAtom.reportRead();
    return super.criticalStatus;
  }

  @override
  set criticalStatus(bool value) {
    _$criticalStatusAtom.reportWrite(value, super.criticalStatus, () {
      super.criticalStatus = value;
    });
  }

  late final _$whereAtom = Atom(name: '_AssetsFilter.where', context: context);

  @override
  String? get where {
    _$whereAtom.reportRead();
    return super.where;
  }

  @override
  set where(String? value) {
    _$whereAtom.reportWrite(value, super.where, () {
      super.where = value;
    });
  }

  late final _$_AssetsFilterActionController =
      ActionController(name: '_AssetsFilter', context: context);

  @override
  void setEnergySensor({bool? value}) {
    final _$actionInfo = _$_AssetsFilterActionController.startAction(
        name: '_AssetsFilter.setEnergySensor');
    try {
      return super.setEnergySensor(value: value);
    } finally {
      _$_AssetsFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCriticalStatus({bool? value}) {
    final _$actionInfo = _$_AssetsFilterActionController.startAction(
        name: '_AssetsFilter.setCriticalStatus');
    try {
      return super.setCriticalStatus(value: value);
    } finally {
      _$_AssetsFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWhere(String? value) {
    final _$actionInfo = _$_AssetsFilterActionController.startAction(
        name: '_AssetsFilter.setWhere');
    try {
      return super.setWhere(value);
    } finally {
      _$_AssetsFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_AssetsFilterActionController.startAction(
        name: '_AssetsFilter.clearFilters');
    try {
      return super.clearFilters();
    } finally {
      _$_AssetsFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
energySensor: ${energySensor},
criticalStatus: ${criticalStatus},
where: ${where}
    ''';
  }
}
