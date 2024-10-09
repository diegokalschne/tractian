class CompanyModel {
  CompanyModel({
    required this.id,
    required this.name,
  });

  CompanyModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
  }

  late final String id;
  late final String name;

  Map toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
