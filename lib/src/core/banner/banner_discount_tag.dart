import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BannerDiscountTag extends StatelessWidget {
  const BannerDiscountTag({
    super.key,
    this.width = 36,
    this.height = 60,
    required this.percentage,
    this.percentageFontSize = 10,
  });
  final double width, height;
  final int percentage;
  final double percentageFontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/Discount_tag.svg",
            fit: BoxFit.fill,
            colorFilter:
                const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
          ),
          Text(
            "$percentage%\noff",
            textAlign: TextAlign.center,
            style: CustomWidget(context: context)
                .CustomSizedTextStyle(
                16.0,
                Theme.of(context).focusColor,
                FontWeight.bold,
                'FontRegular'),
          ),

        ],
      ),
    );
  }
}
