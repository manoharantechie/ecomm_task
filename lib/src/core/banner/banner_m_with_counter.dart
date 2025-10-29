import 'dart:async';

import 'package:e_comm/src/core/banner/blur_container.dart';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'banner_m.dart';

class BannerMWithCounter extends StatefulWidget {
  const BannerMWithCounter({
    super.key,
    this.image = "https://i.imgur.com/pRgcbpS.png",
    required this.text,
    required this.duration,
    required this.press,
  });

  final String image, text;
  final Duration duration;
  final VoidCallback press;

  @override
  State<BannerMWithCounter> createState() => _BannerMWithCounterState();
}

class _BannerMWithCounterState extends State<BannerMWithCounter> {
  late Duration _duration;
  late Timer _timer;

  @override
  void initState() {
    _duration = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: widget.image,
      press: widget.press,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: CustomWidget(context: context)
                  .CustomSizedTextStyle(
                  28.0,
                  Theme.of(context).focusColor,
                  FontWeight.w700,
                  'FontRegular'),
            ),
            const SizedBox(height: ConstantValues.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlurContainer(
                  text: _duration.inHours.toString().padLeft(2, "0"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ConstantValues.defaultPadding / 4),
                  child: SvgPicture.asset("assets/icons/dot.svg"),
                ),
                BlurContainer(
                  text: _duration.inMinutes
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ConstantValues.defaultPadding / 4),
                  child: SvgPicture.asset("assets/icons/dot.svg"),
                ),
                BlurContainer(
                  text: _duration.inSeconds
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
