import 'package:flutter/material.dart';

import '../../constants/assets/assets_path.dart';

class AssetLocationBaseModel {
  AssetLocationBaseModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  factory AssetLocationBaseModel.fromJson(Map json) {
    if (json['sensorType'] != null) {
      return ComponentModel.fromJson(json);
    } else {
      return AssetModel.fromJson(json);
    }
  }

  late final String id;
  late final String name;
  late final String? parentId;

  String get getIcon {
    return switch (runtimeType) {
      const (LocationModel) => AssetsPath.LOCATION_ICON,
      const (AssetModel) => AssetsPath.ASSET_ICON,
      const (ComponentModel) => AssetsPath.COMPONENT_ICON,
      _ => '',
    };
  }

  Widget get suffixIcon => const SizedBox();

  String? get type => null;

  String? get image => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  @override
  String toString() {
    return name;
  }
}

class AssetModel extends AssetLocationBaseModel {
  AssetModel({
    required super.id,
    required super.name,
    super.parentId,
    this.locationId,
  });

  factory AssetModel.fromJson(Map json) {
    return AssetModel(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
    );
  }

  late final String? locationId;

  @override
  String get type => 'Ativo';

  @override
  String get image => AssetsPath.DEFAULT_ASSET_IMAGE;

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['locationId'] = locationId;
    return data;
  }
}

class LocationModel extends AssetLocationBaseModel {
  LocationModel({
    required super.id,
    required super.name,
    super.parentId,
  });

  factory LocationModel.fromJson(Map json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  @override
  String get type => 'Local';

  @override
  String get image => AssetsPath.DEFAULT_LOCATION_IMAGE;
}

class ComponentModel extends AssetLocationBaseModel {
  ComponentModel({
    required super.id,
    required super.name,
    required this.gatewayId,
    required this.sensorType,
    super.parentId,
    this.locationId,
    this.status,
    this.sensorId,
  });

  factory ComponentModel.fromJson(Map json) {
    return ComponentModel(
      id: json['id'],
      name: json['name'],
      gatewayId: json['gatewayId'],
      sensorType: json['sensorType'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      status: json['status'],
    );
  }

  late final String gatewayId;
  late final String? sensorId;
  late final String sensorType;
  late final String? status;
  late final String? locationId;

  @override
  String get type => 'Componente';

  @override
  String get image => AssetsPath.DEFAULT_COMPONENT_IMAGE;

  @override
  Widget get suffixIcon {
    Color? color;

    if (sensorType == 'energy') {
      color = switch (status) {
        'operating' => Colors.green,
        'alert' => Colors.red,
        _ => Colors.grey,
      };

      return Icon(
        Icons.electric_bolt_rounded,
        color: color,
        size: 18,
      );
    } else if (sensorType == 'vibration') {
      color = switch (status) {
        'alert' => Colors.red,
        'operating' => Colors.green,
        _ => Colors.grey,
      };

      return SizedBox(
        width: 10,
        height: 10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'gatewayId': gatewayId,
      'sensorType': sensorType,
      'sensorId': sensorId,
      'status': status,
      'locationId': locationId,
    });
    return data;
  }
}
