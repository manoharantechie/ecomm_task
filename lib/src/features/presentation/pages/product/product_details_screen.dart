import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comm/src/core/routes/route_path.dart';
import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:e_comm/src/features/data/product_model.dart';
import 'package:e_comm/src/features/domain/cubit/cart/cart_cubit.dart';
import 'package:e_comm/src/features/presentation/widgets/cart_button.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:e_comm/src/features/presentation/widgets/notify_me_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductListModel details;

  const ProductDetailsScreen({super.key, required this.details});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductListModel? details;
  String offer = "";
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
    details = widget.details;

    double pr = double.parse(details!.price.toString());
    pr = pr + pr / 2;
    offer = pr.toStringAsFixed(2);

  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartLoaded) {
            final match = state.cartItems.firstWhere(
                  (item) => item['productId'] == details!.id,
              orElse: () => {},
            );
            setState(() {
              quantity = int.tryParse(match['count']?.toString() ?? '0') ?? 0;
            });
          }
        },child:Scaffold(
      backgroundColor: CustomTheme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text('Product Details',style:  CustomWidget(context: context).CustomSizedTextStyle(
          16.0,
          Theme.of(context).focusColor,
          FontWeight.w600,
          'FontRegular',
        ),),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            tooltip: 'Clear Cart',
            onPressed: () {
              context.read<CartCubit>().clearCart();
              context.read<CartCubit>().loadCart();
            },
          ),
        ],
      ),
      body: Container(
        height: ConstantValues.height(context),
        width: ConstantValues.width(context),
        color: CustomTheme.of(context).primaryColorDark,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Curved background
                  ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Container(height: 250, color: Colors.grey[200]),
                  ),

                  // Centered product image
                  Positioned.fill(
                    top: 40,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CachedNetworkImage(
                        height: 160,
                        imageUrl: details!.image!,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Title and Rating
              Text(
                details!.title!,
                style: CustomWidget(context: context).CustomSizedTextStyle(
                  16.0,
                  Theme.of(context).focusColor,
                  FontWeight.w600,
                  'FontRegular',
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Text(
                    details!.rating!.rate.toString(),
                    style: CustomWidget(context: context).CustomSizedTextStyle(
                      14.0,
                      Theme.of(context).focusColor,
                      FontWeight.w400,
                      'FontRegular',
                    ),
                  ),
                  Text(
                    ' (${details!.rating!.count} reviews)',
                    style: CustomWidget(context: context).CustomSizedTextStyle(
                      14.0,
                      Theme.of(context).shadowColor,
                      FontWeight.w400,
                      'FontRegular',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Price and Availability
              Row(
                children: [
                  Text(
                    '\$${details!.price}',
                    style: CustomWidget(context: context).CustomSizedTextStyle(
                      18.0,
                      Theme.of(context).hoverColor,
                      FontWeight.w400,
                      'FontRegular',
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '\$$offer',
                    style: CustomWidget(context: context).CustomSizedTextStyle(
                      18.0,
                      Theme.of(context).shadowColor,
                      FontWeight.w400,
                      'FontRegular',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Available in stock',
                style: CustomWidget(context: context).CustomSizedTextStyle(
                  14.0,
                  Theme.of(context).indicatorColor,
                  FontWeight.w400,
                  'FontRegular',
                ),
              ),
              SizedBox(height: 16),

              // Description
              Text(
                details!.description.toString(),
                style: CustomWidget(context: context).CustomSizedTextStyle(
                  14.0,
                  Theme.of(context).primaryColor,
                  FontWeight.w400,
                  'FontRegular',
                ),
              ),
              SizedBox(height: 16),

              quantity == 0
                  ? SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    final product = ProductDetails(
                      id: details!.id,
                      title: details!.title ?? '',
                      price: details!.price.toString(),
                      description: details!.description ?? '',
                      category: details!.category ?? '',
                      image: details!.image ?? '',
                      rate: details!.rating?.rate.toString() ?? '',
                      count: details!.rating?.count.toString() ?? '',
                      isImportant: true,
                    );

                    context.read<CartCubit>().addToCart(product);
                    context.read<CartCubit>().loadCart();

                    setState(() {
                      quantity = 1;
                    });
                  },
                  child: Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
                  : Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Decrease Button
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: quantity > 0
                          ? () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                          context.read<CartCubit>().decreaseQuantity(
                            details!.id.toString(),
                          );
                        } else {
                          setState(() {
                            quantity = 0;
                          });
                          context.read<CartCubit>().removeFromCart(
                            details!.id!.toInt(),
                          );
                        }
                        context.read<CartCubit>().loadCart();
                      }
                          : null,
                    ),

                    // Quantity Display
                    Text(
                      '$quantity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    // Increase Button
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        final product = ProductDetails(
                          id: details!.id,
                          title: details!.title ?? '',
                          price: details!.price.toString(),
                          description: details!.description ?? '',
                          category: details!.category ?? '',
                          image: details!.image ?? '',
                          rate: details!.rating?.rate.toString() ?? '',
                          count: details!.rating?.count.toString() ?? '',
                          isImportant: true,
                        );

                        context.read<CartCubit>().addToCart(product);
                        context.read<CartCubit>().loadCart();

                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

    ));
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
