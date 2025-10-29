import 'package:e_comm/src/features/data/cart_list_model.dart';
import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:equatable/equatable.dart';


abstract class CartState extends Equatable {}

class CartInit extends CartState {
  @override
  List<Object> get props => [];
}


class CartLoading extends CartState {
  @override
  // List<Object?> get props => throw UnimplementedError();

  List<Object?> get props => [];

}

class CartSucceed extends CartState {
  CartSucceed({required this.response});

  final CartsListModel response;

  @override
  List<Object> get props => [response];
}


class CartFailed extends CartState {

  CartFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

