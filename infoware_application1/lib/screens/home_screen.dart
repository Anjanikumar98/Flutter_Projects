import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/item_bloc.dart';
import 'detail_screen.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ItemBloc>().add(FetchItems());
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ItemError) {
            return Center(child: Text(state.message));
          } else if (state is ItemLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return ItemCard(item: state.items[index]);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
