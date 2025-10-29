import 'dart:convert';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/core/utills/network_utils.dart';
import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:e_comm/src/features/data/product_model.dart';
import 'package:e_comm/src/features/domain/api_utils.dart';
import 'package:e_comm/src/features/domain/cubit/product/product_state.dart';
import 'package:e_comm/src/features/domain/db_service/db_services.dart';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductCubit extends Cubit<ProductState> {
  List<ProductListModel>? output;
  List<ProductDetails>? _productDetails;

  ProductCubit() : super(ProductInit());


  Future<void> getProductList() async {
    emit(ProductLoading());

    final online = await isConnected();

    if (online) {
      try {
        final response = await get(
          Uri.parse(ConstantValues().baseURl + ApiUtils().productListUrl),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        );

        output = (jsonDecode(response.body) as List)
            .map((item) => ProductListModel.fromJson(item))
            .toList();

        if (output != null) {
          emit(ProductListSucceed(response: output!));
          await clearAllProducts(); // 🧹 Clear local DB BEFORE saving new data

          for (final item in output!) {
            await addProduct(
              isImportant: true,
              title: item.title ?? '',
              price: item.price.toString(),
              description: item.description ?? '',
              category: item.category ?? '',
              image: item.image ?? '',
              rate: item.rating?.rate.toString() ?? '',
              count: item.rating?.count.toString() ?? '',
            );
          }



        } else {
          emit(ProductListFailed(message: "API response is empty"));
        }
      } catch (e) {
        print(e);
        emit(ProductListFailed(message: "API error: ${e.toString()}"));
      }
    } else {
      try {
        await fetchProducts(); // Load from local DB
      } catch (e) {
        print(e);
        emit(ProductListFailed(message: "Offline error: ${e.toString()}"));
      }
    }
  }


  Future<void> addProduct({
    required bool isImportant,
    required String title,
    required String price,
    required String description,
    required String category,
    required String image,
    required String rate,
    required String count,

  }) async {
    final product = ProductDetails(
      isImportant: isImportant,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rate: rate,
      count: count,

    );

    await DatabaseService.instance.create(product);
  }


  Future<void> updateProduct(ProductDetails productDetails) async {
    await DatabaseService.instance.update(product: productDetails);
  }

  Future<void> fetchProducts() async {
    final products = await DatabaseService.instance.readAllList();

    _productDetails!.addAll(products);
    emit(ProductDBListSucceed(response: _productDetails!));
  }


  Future<void> deleteProduct(int id) async {
    await DatabaseService.instance.delete(id: id);
    await fetchProducts(); // Refresh the list after deletion
  }

  Future<void> clearAllProducts() async {
    await DatabaseService.instance.truncateTable('products');
  }


}