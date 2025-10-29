import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'banner_m.dart';


class BannerMStyle1 extends StatelessWidget {
  const BannerMStyle1({
    super.key,
    this.image = "https://i.imgur.com/UP7xhPG.png",
    required this.text,
    required this.press,
  });
  final String? image;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(ConstantValues.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  text,
                  style: CustomWidget(context: context)
                      .CustomSizedTextStyle(
                      28.0,
                      Theme.of(context).focusColor,
                      FontWeight.w400,
                      'FontRegular'),
                ),
              ),
              const Spacer(),
               Text(
                "Shop now",
                style: CustomWidget(context: context)
                    .CustomSizedTextStyle(
                    16.0,
                    Theme.of(context).focusColor,
                    FontWeight.w400,
                    'FontRegular'),
              ),
              const SizedBox(
                width: 64,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ],
    );
  }
}
