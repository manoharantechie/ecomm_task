import 'package:e_comm/src/core/banner/banner_discount_tag.dart';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'banner_m.dart';

class BannerMStyle2 extends StatelessWidget {
  const BannerMStyle2({
    super.key,
    this.image = "https://i.imgur.com/J1Qjut7.png",
    required this.title,
    required this.press,
    this.subtitle,
    required this.discountParcent,
  });

  final String? image;
  final String title;
  final String? subtitle;
  final int discountParcent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(ConstantValues.defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: CustomWidget(context: context)
                          .CustomSizedTextStyle(
                            28.0,
                            Theme.of(context).focusColor,
                            FontWeight.w700,
                            'FontRegular',
                          ),
                    ),
                    const SizedBox(height: ConstantValues.defaultPadding / 4),
                    if (subtitle != null)
                      Text(
                        subtitle!.toUpperCase(),
                        style: CustomWidget(context: context)
                            .CustomSizedTextStyle(
                              16.0,
                              Theme.of(context).focusColor,
                              FontWeight.bold,
                              'FontRegular',
                            ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: ConstantValues.defaultPadding),
              GestureDetector(
                onTap: press,
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/arrow.svg',
                      height: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: BannerDiscountTag(percentage: discountParcent),
        ),
      ],
    );
  }
}
