import 'package:e_comm/src/features/presentation/widgets/loader_ring.dart';
import 'package:flutter/material.dart';


class LoadingDialog {
  /// Show as a blocking dialog
  static void show(BuildContext context, {Color color = const Color(0xFFDA9B31)}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54, // semi-transparent background
      builder: (_) => WillPopScope(
        onWillPop: () async => false, // prevent back button
        child: Center(
          child: _LoaderWidget(color: color),
        ),
      ),
    );
  }

  /// Hide the blocking dialog
  static void hide(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// Use as a widget inside BlocBuilder / UI tree
  static Widget widget({Color color = const Color(0xFFDA9B31)}) {
    return Center(
      child: _LoaderWidget(color: color),
    );
  }
}

class _LoaderWidget extends StatelessWidget {
  final Color color;

  const _LoaderWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: ThreeArchedCircle(color: color, size: 50),
        ),
      ),
    );
  }
}
