import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ItemRepository {
  final String apiUrl = 'https://api.apis.guru/v2/list.json';

  Future<List<ItemModel>> fetchItems() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // Decode the JSON response
      final data = jsonDecode(response.body) as List<dynamic>;
      // Convert JSON data to a list of ItemModel objects
      return data.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
