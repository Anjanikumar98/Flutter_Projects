import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_application1/ViewModel/world_sates_view_model.dart';

import '../bloc/worldstatebloc.dart';

class WorldStatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WorldStatesBloc(WorldStatesBloc as WorldStatesViewModel),
        child: BlocBuilder<WorldStatesBloc, WorldStatesState>(
          builder: (context, state) {
            if (state is WorldStatesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WorldStatesLoaded) {
              return Column(
                children: [
                  // Your PieChart and ReusableRow widgets here
                ],
              );
            } else if (state is WorldStatesError) {
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
