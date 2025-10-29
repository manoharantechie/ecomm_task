import 'package:e_comm/src/features/data/product_model.dart';
import 'package:e_comm/src/features/domain/db_service/cart_db_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final CartDatabaseService cartDb;

  CartCubit(this.cartDb) : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final items = await cartDb.readCartItems();
      emit(CartLoaded(cartItems: items));
    } catch (e) {
      emit(CartError(message: 'Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> addToCart(ProductDetails product) async {
    await cartDb.addToCart(product);
    await loadCart(); // Refresh state
  }

  Future<void> removeFromCart(int productId) async {
    await cartDb.removeFromCart(productId);
    await loadCart(); // Refresh state
  }

  Future<void> clearCart() async {
    await cartDb.clearCart();
    await loadCart(); // Refresh state
  }

  void decreaseQuantity(String productId) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = currentState.cartItems.map((item) {
        if (item['productId'] == productId) {
          final currentCount = int.tryParse(item['count'].toString()) ?? 1;
          if (currentCount > 1) {
            return {
              ...item,
              'count': currentCount - 1,
            };
          }
          // If count is 1, remove item
          return null;
        }
        return item;
      }).whereType<Map<String, dynamic>>().toList();

      emit(CartLoaded(cartItems: updatedItems));
    }
  }

}
