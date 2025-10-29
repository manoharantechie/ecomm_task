import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:flutter/material.dart';


class DotIndicator extends StatelessWidget {
   DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = Colors.blue,
  });

  final bool isActive;

  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? Colors.blue.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(ConstantValues.defaultPadding)),
      ),
    );
  }
}
