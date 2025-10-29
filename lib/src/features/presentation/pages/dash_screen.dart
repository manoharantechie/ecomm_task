import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/core/routes/route_path.dart';
import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:e_comm/src/features/domain/cubit/cart/cart_cubit.dart';
import 'package:e_comm/src/features/domain/cubit/product/product_cubit.dart';
import 'package:e_comm/src/features/domain/cubit/product/product_state.dart';
import 'package:e_comm/src/features/presentation/widgets/carousel.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:e_comm/src/features/presentation/widgets/loading_widget.dart';
import 'package:e_comm/src/features/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  List<ProductListModel> productsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCubit>().getProductList();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.of(context).primaryColorDark,
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return LoadingDialog.widget();
          } else if (state is ProductListSucceed) {
            productsList = state.response;

            return productViewUI(productsList);
          } else if (state is ProductDBListSucceed) {
            productsList = state.response
                .map(
                  (e) => ProductListModel(
                    id: e.id,
                    title: e.title,
                    price: double.tryParse(e.price) ?? 0.0,
                    description: e.description,
                    category: e.category,
                    image: e.image,
                    rating: Rating(
                      rate: double.tryParse(e.rate) ?? 0.0,
                      count: int.tryParse(e.count) ?? 0,
                    ),
                  ),
                )
                .toList();
            return productViewUI(productsList);
          }
          return LoadingDialog.widget();
        },
      ),

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
                  // Total items and amount
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

                  // Checkout button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                        AppRoute.cart.name,
                      );
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

          return SizedBox.shrink(); // Hide if cart is empty
        },
      ),
    );
  }

  Widget productViewUI(List<ProductListModel> productsList) {
    return Container(
      height: ConstantValues.height(context),
      width: ConstantValues.width(context),
      color: CustomTheme.of(context).primaryColorDark,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: ConstantValues.height(context) * 0.2,
              width: ConstantValues.width(context),
              child: OffersCarousel(),
            ),
            const SizedBox(height: 15.0),
            
            GestureDetector(
              onTap: (){
                GoRouter.of(context).pushNamed(
                  AppRoute.productlist.name,
                );
              },
              child: Container(
                width: ConstantValues.width(context),
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Products',
                      style:CustomWidget(context: context)
                          .CustomSizedTextStyle(
                          16.0,
                          Theme.of(context).focusColor,
                          FontWeight.w600,
                          'FontRegular'),
                    ),
                    Row(
                      children: [
                        Text(
                          'View all',
                          style:CustomWidget(context: context)
                              .CustomSizedTextStyle(
                              12.0,
                              Theme.of(context).focusColor,
                              FontWeight.w600,
                              'FontRegular'),
                        ),
                        const SizedBox(width: 5.0,),
                        Icon(Icons.arrow_forward_ios_outlined,size: 15.0,)
                      ],
                    )
                  ],
                ),
              ),
            ),

            
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              // Ensures no internal padding
              itemCount: productsList.length > 10 ? 10 : productsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                final product = productsList[index];
                double pr = double.parse(product.price.toString());
                pr = pr + pr / 2;

                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      AppRoute.productdetails.name,
                      extra: {"details": productsList[index]},
                    );
                  },
                  child:    ProductCard(
                    imageUrl: product.image as String,
                    title: product.title as String,
                    price: product.price,
                    originalPrice: 1.0,
                    discount: product.rating!.rate,
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
