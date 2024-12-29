import 'package:flutter/material.dart';
import '../models/item_model.dart';

class DetailScreen extends StatelessWidget {
  final ItemModel item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Column(
        children: [
          Image.network(item.imageUrl),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(item.description),
          ),
        ],
      ),
    );
  }
}
