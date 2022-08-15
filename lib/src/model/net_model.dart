import 'dart:convert';

// String netModelToJson(List<NetModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<NetModel> netModelFromJson(String str) =>
    List<NetModel>.from(json.decode(str).map((x) => NetModel.fromJson(x)));

class NetModel {
  NetModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.fullName,
    required this.image,
    required this.price,
    required this.drugId,
    this.favourite = false,
  });

  int id;
  String name;
  String slug;
  String fullName;
  String image;
  double price;
  int drugId;
  bool favourite;

  factory NetModel.fromJson(Map<String, dynamic> json) => NetModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        slug: json["slug"] ?? "",
        fullName: json["full_name"] ?? "",
        image: json["image"] ?? "",
        price: json["price"] ?? 0.0,
        drugId: json["drug_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "full_name": fullName,
        "image": image,
        "price": price,
        "drug_id": drugId,
      };
}
