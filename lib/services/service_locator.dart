import 'package:flutter/material.dart';

import '../models/filters/assets_filter.dart';

final locator = ServiceLocator();

void serviceLocator() {
  locator.registerSingleton(AssetsFilter());

  locator.registerSingleton(GlobalKey<NavigatorState>());
}

class ServiceLocator {
  final Map<Type, dynamic> _instances = {};

  final Map<Type, Function> _factories = {};

  void registerSingleton<T>(T instance) {
    _instances[T] = instance;
  }

  void registerLazySingleton<T>(T Function() factory) {
    _factories[T] = factory;
  }

  T call<T>() {
    return get<T>();
  }

  T get<T>() {
    if (_instances.containsKey(T)) {
      return _instances[T];
    }

    if (_factories.containsKey(T)) {
      final instance = _factories[T]!();
      _instances[T] = instance;
      return instance;
    }

    throw Exception('Type $T: Unregistered class');
  }
}
