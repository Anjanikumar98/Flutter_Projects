import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../screens/detail_screen.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(item.imageUrl),
        title: Text(item.title),
        subtitle: Text(item.description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(item: item),
            ),
          );
        },
      ),
    );
  }
}
