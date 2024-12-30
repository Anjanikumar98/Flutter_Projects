import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_application1/Screens/product_detail_screen.dart';

import 'audioplayer_screen.dart';
import '../bloc/event.dart';
import '../bloc/product_bloc.dart';
import '../bloc/state.dart';
import 'form_screen.dart';


class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.person_add, color: Colors.blue),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserFormScreen()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.music_note, color: Colors.blue),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AudioPlayerScreen()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_add, color: Colors.blue),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserFormScreen()),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            context.read<ProductBloc>().add(FetchProducts());
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(8), // Reduced padding
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Increased from 2 to 3 items per row
                childAspectRatio: 0.7,
                crossAxisSpacing: 8, // Reduced spacing
                mainAxisSpacing: 8,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8), // Reduced border radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5, // Reduced blur
                          offset: Offset(0, 2), // Reduced offset
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                            ),
                            child: Center(
                              child: Icon(Icons.shopping_bag, size: 24, color: Colors.blue), // Reduced icon size
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8), // Reduced padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1, // Reduced to 1 line
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12, // Reduced font size
                                ),
                              ),
                              SizedBox(height: 4), // Reduced spacing
                              Text(
                                '\$${product.price}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14, // Reduced font size
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
