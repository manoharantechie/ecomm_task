import 'dart:io';


import 'package:e_comm/src/features/presentation/widgets/bottom_bar/bar_with_indicator_theme.dart';
import 'package:e_comm/src/features/presentation/widgets/bottom_bar/bar_with_indicator_theme_data.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarWithIndicator extends StatelessWidget {
  final List<BottomBarWithIndicatorItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onIndexChanged;
  final BarWithIndicatorThemeData? themeData;

  const BottomBarWithIndicator({
    required this.items,
    required this.selectedIndex,
    this.onIndexChanged,
    this.themeData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BarWithIndicatorTheme(
      data: themeData ?? BarWithIndicatorThemeData(),
      child: _BarContainer(
        items: items,
        selectedIndex: selectedIndex,
        onIndexChanged: onIndexChanged,
      ),
    );
  }
}

class _BarContainer extends StatefulWidget {
  final List<BottomBarWithIndicatorItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onIndexChanged;

  const _BarContainer({
    required this.items,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  State<_BarContainer> createState() => _BarContainerState();
}

class _BarContainerState extends State<_BarContainer>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.items.length, vsync: this)
      ..index = widget.selectedIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final floating = BarWithIndicatorTheme.of(context).floating;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
          Colors.white,

        ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.items.length, (index) {
          return GestureDetector(
            onTap: () {
              widget.onIndexChanged?.call(index);
            },
            child: _BarItem(
              item: widget.items[index],
              itemColor: index == widget.selectedIndex
                  ? BarWithIndicatorTheme.of(context).activeColor
                  : BarWithIndicatorTheme.of(context).inactiveColor,
              selectedIndex: widget.selectedIndex,
              itemIndex: index,
            ),
          );
        }),
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  final BottomBarWithIndicatorItem item;
  final Color itemColor;
  final int selectedIndex;
  final int itemIndex;

  const _BarItem({
    required this.item,
    required this.itemColor,
    required this.itemIndex,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SvgPicture.asset(selectedIndex == itemIndex ? item.activeIcon : item.icon,height: 24.0,color: itemColor,)
        ),

        Text(
          item.label,
          style: CustomWidget(context: context)
              .CustomSizedTextStyle(
              14.0,
              itemColor,
              FontWeight.w400,
              'FontRegular'),
        ),
      ],
    );
  }
}

class BottomBarWithIndicatorItem {
  final String icon;
  final String activeIcon;
  final String label;

  const BottomBarWithIndicatorItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}