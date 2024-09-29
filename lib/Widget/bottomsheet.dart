import 'package:deliveryboy_multivendor/Helper/color.dart';
import 'package:deliveryboy_multivendor/Helper/constant.dart';
import 'package:deliveryboy_multivendor/Widget/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  static Future<dynamic> showBottomSheet(
      {required Widget child,
      required BuildContext context,
      bool? enableDrag}) async {
    final result = await showModalBottomSheet(
      enableDrag: enableDrag ?? false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) => child,
    );
    return result;
  }

  static Widget bottomSheetHandle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightBlack2,
        ),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }

  static Widget bottomSheetLabel(BuildContext context, String labelName) =>
      Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 10),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            getTranslated(context, labelName)!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ubuntu',
                ),
          ),
        ),
      );
  static Widget button(
    BuildContext context,
    String? title, {
    VoidCallback? onBtnSelected,
    IconData? icon,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          top: 20,
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
              // width: btnAnim!.value,
              width: MediaQuery.of(context).size.width,
              height: 45,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                color: primary,
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [grad1Color, grad2Color],
                //   stops: [0, 1],
                // ),
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  const Radius.circular(circularBorderRadius10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: white,
                  ),
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )),
          onPressed: () {
            onBtnSelected!();
          },
        ),
      );

  static Widget bottomSheetText(BuildContext context, String labelName) =>
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          getTranslated(context, labelName)!,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(),
        ),
      );
}
