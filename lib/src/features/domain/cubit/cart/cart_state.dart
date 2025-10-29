part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Map<String, dynamic>> cartItems;

  CartLoaded({required this.cartItems});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
