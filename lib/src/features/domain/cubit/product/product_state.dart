import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:e_comm/src/features/data/product_model.dart';
import 'package:equatable/equatable.dart';


abstract class ProductState extends Equatable {}

class ProductInit extends ProductState {
  @override
  List<Object> get props => [];
}


class ProductLoading extends ProductState {
  @override
  // List<Object?> get props => throw UnimplementedError();

  List<Object?> get props => [];

}

class ProductListSucceed extends ProductState {
  ProductListSucceed({required this.response});

  final List<ProductListModel> response;

  @override
  List<Object> get props => [response];
}
class ProductDBListSucceed extends ProductState {
  ProductDBListSucceed({required this.response});

  final List<ProductDetails> response;

  @override
  List<Object> get props => [response];
}

class ProductListFailed extends ProductState {

  ProductListFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

