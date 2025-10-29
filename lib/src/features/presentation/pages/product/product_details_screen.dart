import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:e_comm/src/features/presentation/widgets/cart_button.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:e_comm/src/features/presentation/widgets/notify_me_card.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductListModel details;
  const ProductDetailsScreen({super.key, required this.details});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  ProductListModel? details;
  String offer="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    details=widget.details;
    double pr = double.parse(details!.price.toString());
    pr = pr + pr / 2;
    offer=pr.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Product Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                // Curved background
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    height: 250,
                    color: Colors.grey[200],
                  ),
                ),

                // Centered product image
                Positioned.fill(
                  top: 40,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child:  CachedNetworkImage(
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
              style:CustomWidget(context: context)
                  .CustomSizedTextStyle(
                  16.0,
                  Theme.of(context).focusColor,
                  FontWeight.w600,
                  'FontRegular'),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                Text(details!.rating!.rate.toString(), style: CustomWidget(context: context)
                    .CustomSizedTextStyle(
                    14.0,
                    Theme.of(context).focusColor,
                    FontWeight.w400,
                    'FontRegular'),),
                Text(' (${details!.rating!.count} reviews)', style: CustomWidget(context: context)
                    .CustomSizedTextStyle(
                    14.0,
                    Theme.of(context).shadowColor,
                    FontWeight.w400,
                    'FontRegular'),),
              ],
            ),
            SizedBox(height: 8),

            // Price and Availability
            Row(
              children: [
                Text('\$${details!.price}',
                    style: CustomWidget(context: context)
                        .CustomSizedTextStyle(
                        18.0,
                        Theme.of(context).hoverColor,
                        FontWeight.w400,
                        'FontRegular')),
                SizedBox(width: 8),
                Text('\$$offer',
                    style: CustomWidget(context: context)
                        .CustomSizedTextStyle(
                        18.0,
                        Theme.of(context).shadowColor,
                        FontWeight.w400,
                        'FontRegular')),
              ],
            ),
            SizedBox(height: 4),
            Text('Available in stock',
                style: CustomWidget(context: context)
                    .CustomSizedTextStyle(
                    14.0,
                    Theme.of(context).indicatorColor,
                    FontWeight.w400,
                    'FontRegular')),
            SizedBox(height: 16),

            // Description
            Text(
             details!.description.toString(),
              style: CustomWidget(context: context)
                  .CustomSizedTextStyle(
                  14.0,
                  Theme.of(context).primaryColor,
                  FontWeight.w400,
                  'FontRegular'),
            ),
            SizedBox(height: 16),



            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {},
                child: Text('Add to cart',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CartButton(
        price: 140,
        press: () {
          // customModalBottomSheet(
          //   context,
          //   height: MediaQuery.of(context).size.height * 0.92,
          //   child: const ProductBuyNowScreen(),
          // );
        },
      ),

    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}