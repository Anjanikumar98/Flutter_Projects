import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:infoware_application1/bloc/state.dart';
import '../Models/model.dart';
import 'event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final http.Client httpClient;

  ProductBloc({required this.httpClient}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await httpClient.get(
            Uri.parse('https://fakestoreapi.com/products')
        );
        if (response.statusCode == 200) {
          final List<dynamic> jsonList = json.decode(response.body);
          final products = jsonList.map((json) => Product.fromJson(json)).toList();
          emit(ProductLoaded(products));
        } else {
          emit(ProductError('Failed to fetch products'));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
