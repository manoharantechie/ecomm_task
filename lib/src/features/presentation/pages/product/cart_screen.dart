import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/data/product_model.dart';
import 'package:e_comm/src/features/domain/cubit/cart/cart_cubit.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.of(context).primaryColorDark,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Your cart',
          style: CustomWidget(context: context).CustomSizedTextStyle(
            16.0,
            Theme.of(context).focusColor,
            FontWeight.w600,
            'FontRegular',
          ),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.cartItems.isNotEmpty) {
            int totalItems = 0;
            double totalAmount = 0;

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                final item = state.cartItems[index];
                final count = int.tryParse(item['count'].toString()) ?? 0;
                final price = double.tryParse(item['price'].toString()) ?? 0;
                totalItems += count;
                totalAmount += count * price;

                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Product Image
                        Image.network(item['image'], height: 60, width: 60),
                        SizedBox(width: 12),

                        // Product Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '₹${price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Quantity Controls
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                if (count > 1) {
                                  context.read<CartCubit>().decreaseQuantity(
                                    item['productId'],
                                  );
                                } else {
                                  context.read<CartCubit>().removeFromCart(
                                    item['productId'],
                                  );
                                }
                                context.read<CartCubit>().loadCart();
                              },
                            ),
                            Text(
                              '$count',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                final product = ProductDetails(
                                  id: item['productId'],
                                  title: item['title'],
                                  price: item['price'],
                                  description: item['description'],
                                  category: item['category'],
                                  image: item['image'],
                                  rate: item['rate'],
                                  count: item['count'],
                                  isImportant: true,
                                );
                                context.read<CartCubit>().addToCart(product);
                                context.read<CartCubit>().loadCart();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/cart.png',height: ConstantValues.height(context)*0.1,),
                  const SizedBox(height: 15.0,),
                  Text('Your cart is empty.',style: CustomWidget(context: context).CustomSizedTextStyle(
                    14.0,
                    Theme.of(context).focusColor,
                    FontWeight.w600,
                    'FontRegular',
                  ),),
                ],
              ),
            );
          }
        },
      ),

      // Bottom Summary Bar
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.cartItems.isNotEmpty) {
            int totalItems = 0;
            double totalAmount = 0;

            for (var item in state.cartItems) {
              final count = int.tryParse(item['count'].toString()) ?? 0;
              final price = double.tryParse(item['price'].toString()) ?? 0;
              totalItems += count;
              totalAmount += count * price;
            }

            return Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Summary
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items: $totalItems',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Total: ₹${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Checkout Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      // Navigate to checkout
                    },
                    child: Text(
                      'Checkout',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
