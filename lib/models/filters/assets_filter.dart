import 'package:mobx/mobx.dart';

part 'assets_filter.g.dart';

class AssetsFilter = _AssetsFilter with _$AssetsFilter;

abstract class _AssetsFilter with Store {
  @observable
  bool energySensor = false;

  @observable
  bool criticalStatus = false;

  @observable
  String? where;

  @action
  void setEnergySensor({bool? value}) {
    energySensor = value ?? !energySensor;
  }

  @action
  void setCriticalStatus({bool? value}) {
    criticalStatus = value ?? !criticalStatus;
  }

  @action
  void setWhere(String? value) {
    where = value;
  }

  @action
  void clearFilters() {
    where = null;
    energySensor = false;
    criticalStatus = false;
  }
}
