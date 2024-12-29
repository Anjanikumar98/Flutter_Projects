import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/world_states.dart';
import 'Utilities/app_url.dart';

class WorldStatesViewModel {

  // Helper method to handle API calls
  Future<dynamic> _fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  // Fetch world records
  Future<WorldStatesModel> fetchWorldRecords() async {
    final data = await _fetchData(AppUrl.worldStatesApi);
    return WorldStatesModel.fromJson(data);  // Parse the data into the model
  }

  // Fetch list of countries
  Future<List<dynamic>> countriesListApi() async {
    final data = await _fetchData(AppUrl.countriesList);
    return data;  // Returns a list of countries data
  }
}
