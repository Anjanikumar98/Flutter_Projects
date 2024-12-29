import 'dart:convert';

class ItemModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  ItemModel({required this.id, required this.title, required this.description, required this.imageUrl});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  static List<ItemModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((json) => ItemModel.fromJson(json)).toList();
  }
}
