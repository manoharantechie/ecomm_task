import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comm/src/core/routes/route_path.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {

  final String imageUrl;
  final String title;
  final dynamic price;
  final dynamic originalPrice;
  final dynamic discount;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 4,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Product Image

              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  height: 160,
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:CustomWidget(context: context)
                          .CustomSizedTextStyle(
                          14.0,
                          Theme.of(context).focusColor,
                          FontWeight.w600,
                          'FontRegular'),
                    ),
                    const SizedBox(height: 6),
                    // Price and Discount
                    Row(
                      children: [
                        Text(
                          '\$${price}',
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                              16.0,
                              Theme.of(context).indicatorColor,
                              FontWeight.w400,
                              'FontRegular'),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '\$${double.parse(originalPrice.toString()).toStringAsFixed(2)}',
                            style: CustomWidget(context: context)
                                .CustomSizedTextStyle(
                                14.0,
                                Theme.of(context).shadowColor,
                                FontWeight.w400,
                                'FontRegular'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: discount != null
              ? Padding(
            padding: const EdgeInsets.only(right: 8,top: 10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${discount!.toStringAsFixed(0)}% Off',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
              : SizedBox(width: 0.0),
        ),
      ],
    );
  }
}
