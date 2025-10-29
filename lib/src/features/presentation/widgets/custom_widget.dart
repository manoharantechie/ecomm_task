import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';


class CustomWidget {
  final BuildContext context;

  CustomWidget({required this.context});


  CustomTextStyle(Color color, FontWeight weight, String family) {
    return GoogleFonts.poppins(
        fontWeight: weight, color: color, fontSize: 13.0);
  }

  CustomSizedTextStyle(
      double size, Color color, FontWeight weight, String family) {
    return GoogleFonts.poppins(
        fontWeight: weight, color: color, fontSize: size);
  }

  CustomSizedColorTextStyle(
      double size ,FontWeight weight, String family) {
    return GoogleFonts.poppins(
        fontWeight: weight, fontSize: size);
  }

  Widget noInternet() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color:  Color(0xFF1d0068),
      child: Center(
        child: Container(
          child: Center(child: Image.asset('assets/image/internet.png')),
        ),
      ),
    );
  }

  Widget noRecordsFound(String data, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(data,
            style: TextStyle(
              fontFamily: "FontRegular",
              color: color,
            )),
      ),
    );
  }


  // displayCustomMotionToast(String mess,bool type) {
  //
  //   toastification.dismissAll();
  //   toastification.show(
  //     context: context, // optional if you use ToastificationWrapper
  //     type:type? ToastificationType.success:ToastificationType.error,
  //     style: ToastificationStyle.fillColored,
  //     autoCloseDuration: const Duration(seconds: 5),
  //     title: Text(mess,style: CustomWidget(context: context)
  //         .CustomSizedTextStyle(
  //         14.0,
  //         Theme.of(context).focusColor,
  //         FontWeight.w500,
  //         'FontRegular'),),
  //
  //     alignment: Alignment.topRight,
  //     direction: TextDirection.ltr,
  //     animationDuration: const Duration(milliseconds: 300),
  //     animationBuilder: (context, animation, alignment, child) {
  //       return FadeTransition(
  //
  //         opacity: animation,
  //         child: child,
  //       );
  //     },
  //     icon:  Icon(type?Icons.check:Icons.close),
  //     showIcon: true, // show or hide the icon
  //     primaryColor:type?Colors.green:Colors.red,
  //     backgroundColor: Colors.white,
  //     foregroundColor: Colors.black,
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  //     margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //     borderRadius: BorderRadius.circular(12),
  //     boxShadow: const [
  //       BoxShadow(
  //         color: Color(0x07000000),
  //         blurRadius: 16,
  //         offset: Offset(0, 16),
  //         spreadRadius: 0,
  //       )
  //     ],
  //     showProgressBar: false,
  //     closeButton: ToastCloseButton(
  //       showType: CloseButtonShowType.onHover,
  //       buttonBuilder: (context, onClose) {
  //         return OutlinedButton.icon(
  //           onPressed: onClose,
  //           icon: const Icon(Icons.close, size: 20),
  //           label: const Text('Close'),
  //         );
  //       },
  //     ),
  //     closeOnClick: false,
  //     pauseOnHover: true,
  //     dragToClose: true,
  //     applyBlurEffect: true,
  //     callbacks: ToastificationCallbacks(
  //       onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
  //       onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
  //       onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
  //       onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
  //     ),
  //   );
  //
  //
  // }


}
