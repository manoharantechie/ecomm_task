import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NotifyMeCard extends StatelessWidget {
  const NotifyMeCard({
    super.key,
    this.isNotify = false,
    required this.onChanged,
  });

  final bool isNotify;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ConstantValues.defaultPadding, vertical: ConstantValues.defaultPadding / 2),
        child: Container(
          decoration: BoxDecoration(
            color: isNotify ? Colors.red : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            border: Border.all(
              color: isNotify
                  ? Colors.transparent
                  : Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(ConstantValues.defaultPadding),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: Colors.white10),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Notification.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: ConstantValues.defaultPadding),
                Expanded(
                  child: Text(
                    "Notify when product back to stock.",
                    style: TextStyle(
                        color: isNotify
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                CupertinoSwitch(
                  onChanged: onChanged,
                  value: isNotify,
                  activeColor: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
