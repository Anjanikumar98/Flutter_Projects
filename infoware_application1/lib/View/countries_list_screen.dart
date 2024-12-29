import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../ViewModel/world_sates_view_model.dart';
import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  late Future<List<dynamic>> countriesListFuture;
  late WorldStatesViewModel worldStatesViewModel;

  @override
  void initState() {
    super.initState();
    worldStatesViewModel = WorldStatesViewModel();
    countriesListFuture = worldStatesViewModel.countriesListApi();
  }

  // Refactored widget for individual country item
  Widget _buildCountryItem(Map countryData) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              image: countryData['countryInfo']['flag'],
              name: countryData['country'],
              totalCases: countryData['cases'],
              totalRecovered: countryData['recovered'],
              totalDeaths: countryData['deaths'],
              active: countryData['active'],
              test: countryData['tests'],
              todayRecovered: countryData['todayRecovered'],
              critical: countryData['critical'],
            ),
          ),
        );
      },
      child: ListTile(
        leading: Image(
          height: 50,
          width: 50,
          image: NetworkImage(countryData['countryInfo']['flag']),
        ),
        title: Text(countryData['country']),
        subtitle: Text("Affected: ${countryData['cases']}"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Search with country name',
                  suffixIcon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                    onTap: () {
                      searchController.clear();
                      setState(() {});
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: countriesListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(height: 50, width: 50, color: Colors.white),
                                title: Container(width: 100, height: 8.0, color: Colors.white),
                                subtitle: Container(width: double.infinity, height: 8.0, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("No countries found"),
                    );
                  }

                  final filteredCountries = snapshot.data!
                      .where((country) => country['country']
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      return _buildCountryItem(filteredCountries[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
