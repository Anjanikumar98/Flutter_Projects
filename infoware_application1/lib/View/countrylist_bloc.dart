import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_application1/ViewModel/world_sates_view_model.dart';

import '../bloc/countrylistbloc.dart';



class CountriesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CountriesListBloc(CountriesListScreen as WorldStatesViewModel),
        child: BlocBuilder<CountriesListBloc, CountriesListState>(
          builder: (context, state) {
            if (state is CountriesListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CountriesListLoaded) {
              return ListView.builder(
                itemCount: state.countries.length,
                itemBuilder: (context, index) {
                  final country = state.countries[index];
                  return ListTile(
                    title: Text(country['country']),
                    subtitle: Text('Cases: ${country['cases']}'),
                    onTap: () {
                      // Navigate to detail screen
                    },
                  );
                },
              );
            } else if (state is CountriesListError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
