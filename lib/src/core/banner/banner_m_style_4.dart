import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'banner_m.dart';


class BannerMStyle4 extends StatelessWidget {
  const BannerMStyle4({
    super.key,
    this.image = "https://i.imgur.com/R4iKkDD.png",
    required this.title,
    required this.press,
    required this.discountParcent,
    this.subtitle,
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
                    if (subtitle != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: ConstantValues.defaultPadding / 2,
                            vertical: ConstantValues.defaultPadding / 8),
                        color: Colors.white70,
                        child: Text(
                          subtitle!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: ConstantValues.defaultPadding / 2),
                    Text(
                      title.toUpperCase(),
                      style:CustomWidget(context: context)
                          .CustomSizedTextStyle(
                          28.0,
                          Theme.of(context).focusColor,
                          FontWeight.w700,
                          'FontRegular'),
                    ),
                    // const SizedBox(height: defaultPadding / 4),
                    Text(
                      "UP TO $discountParcent% OFF",
                      style: CustomWidget(context: context)
                          .CustomSizedTextStyle(
                          12.0,
                          Theme.of(context).focusColor,
                          FontWeight.bold,
                          'FontRegular'),
                    )
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
      ],
    );
  }
}
