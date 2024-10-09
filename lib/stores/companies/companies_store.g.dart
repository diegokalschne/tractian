// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CompaniesStore on _CompaniesStore, Store {
  Computed<List<CompanyModel>>? _$companiesComputed;

  @override
  List<CompanyModel> get companies => (_$companiesComputed ??=
          Computed<List<CompanyModel>>(() => super.companies,
              name: '_CompaniesStore.companies'))
      .value;

  late final _$_companiesAtom =
      Atom(name: '_CompaniesStore._companies', context: context);

  @override
  ObservableList<CompanyModel> get _companies {
    _$_companiesAtom.reportRead();
    return super._companies;
  }

  @override
  set _companies(ObservableList<CompanyModel> value) {
    _$_companiesAtom.reportWrite(value, super._companies, () {
      super._companies = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_CompaniesStore.loading', context: context);

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
      Atom(name: '_CompaniesStore.hasError', context: context);

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
      Atom(name: '_CompaniesStore.hasInternet', context: context);

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

  late final _$_CompaniesStoreActionController =
      ActionController(name: '_CompaniesStore', context: context);

  @override
  void setLoading({required bool value}) {
    final _$actionInfo = _$_CompaniesStoreActionController.startAction(
        name: '_CompaniesStore.setLoading');
    try {
      return super.setLoading(value: value);
    } finally {
      _$_CompaniesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasError({required bool value}) {
    final _$actionInfo = _$_CompaniesStoreActionController.startAction(
        name: '_CompaniesStore.setHasError');
    try {
      return super.setHasError(value: value);
    } finally {
      _$_CompaniesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasInternet({required bool value}) {
    final _$actionInfo = _$_CompaniesStoreActionController.startAction(
        name: '_CompaniesStore.setHasInternet');
    try {
      return super.setHasInternet(value: value);
    } finally {
      _$_CompaniesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCompanies(List<CompanyModel> companies, {bool saveCache = true}) {
    final _$actionInfo = _$_CompaniesStoreActionController.startAction(
        name: '_CompaniesStore.setCompanies');
    try {
      return super.setCompanies(companies, saveCache: saveCache);
    } finally {
      _$_CompaniesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
hasError: ${hasError},
hasInternet: ${hasInternet},
companies: ${companies}
    ''';
  }
}
