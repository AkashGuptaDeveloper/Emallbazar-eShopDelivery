import 'dart:io';

import 'package:deliveryboy_multivendor/Screens/CashCollection/Widget/getDialogs.dart';
import 'package:deliveryboy_multivendor/Screens/CashCollection/cash_collection.dart';
import 'package:deliveryboy_multivendor/Widget/ButtonDesing.dart';
import 'package:deliveryboy_multivendor/Widget/translateVariable.dart';
import 'package:deliveryboy_multivendor/Widget/validation.dart';
import 'package:flutter/material.dart';
import '../../../Helper/color.dart';
import '../../../Helper/constant.dart';
import '../../../Widget/bottomsheet.dart';
import '../../../Widget/parameterString.dart';

// getAppBar(String title, BuildContext context, Function update, bool isBack) {
//   return Container(
//     // height: 90,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       gradient: LinearGradient(
//         colors: [grad1Color, grad2Color],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         stops: [0, 1],
//         tileMode: TileMode.clamp,
//       ),
//     ),
//     width: MediaQuery.of(context).size.width,
//     child: SafeArea(
//       child:
//           // Column(
//           //   children: [
//           // Opacity(
//           //   opacity: 0.17000000178813934,
//           //   child: Container(
//           //     width: deviceWidth! * 0.9,
//           //     height: 1,
//           //     decoration: const BoxDecoration(
//           //       color: white,
//           //     ),
//           //   ),
//           // ),
//           Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Align(
//               alignment: Alignment.centerLeft,
//               child: isBack
//                   ? InkWell(
//                       onTap: () => Navigator.of(context).pop(),
//                       child: const Padding(
//                         padding: EdgeInsetsDirectional.only(start: 15.0),
//                         child: Icon(
//                           Icons.arrow_back,
//                           color: white,
//                           size: 25,
//                         ),
//                       ),
//                     )
//                   : Container()
//               // SizedBox(
//               //     width: 15,
//               //   ),
//               ),
//           Container(
//             height: 36,
//             child: Padding(
//               padding: const EdgeInsetsDirectional.only(
//                 top: 9.0,
//                 /*  start: 15,
//                     end: 15, */
//               ),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontFamily: 'PlusJakartaSans',
//                   color: white,
//                   fontSize: textFontSize16,
//                   fontWeight: FontWeight.w400,
//                   fontStyle: FontStyle.normal,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsetsDirectional.only(end: 15.0),
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           return GetDialogs.orderSortDialog(context, update);
//                         },
//                         child: Icon(
//                           Icons.search,
//                           color: white,
//                           size: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsetsDirectional.only(end: 15.0),
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           return GetDialogs.orderSortDialog(context, update);
//                         },
//                         child: Icon(
//                           Icons.swap_vert,
//                           color: white,
//                           size: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsetsDirectional.only(end: 15.0),
//                 //   child: Row(
//                 //     children: [
//                 //       InkWell(
//                 //         onTap: () {
//                 //           return GetDialogs.filterDialog(context, update);
//                 //         },
//                 //         child: Icon(
//                 //           Icons.tune,
//                 //           color: white,
//                 //           size: 18,
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       //   ],
//       // ),
//     ),
//   );
// }

class GradientAppBar2 extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final Function update;
  // final double barHeight = 80.0;
  final bool? customback;

  GradientAppBar2(this.title, this.context, this.update, {this.customback});

  @override
  State<GradientAppBar2> createState() => _GradientAppBar2State();

  @override
  Size get preferredSize => Size(deviceWidth!, 50);
}

class _GradientAppBar2State extends State<GradientAppBar2> {
  bool serachIsEnable = false;

  void _handleSearchEnd() {
    if (!mounted) return;
    setState(
      () {
        serachIsEnable = false;
        cashCollectionProvider!.controllerText.clear();
      },
    );
  }

  void _handleSearchStart() {
    if (!mounted) return;
    setState(
      () {},
    );
  }

  _showBottomSheet() async {
    await CustomBottomSheet.showBottomSheet(
      context: context,
      enableDrag: true,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 10,
                  right: 10),
              child: Column(
                children: [
                  CustomBottomSheet.bottomSheetHandle(context),
                  CustomBottomSheet.bottomSheetLabel(
                    context,
                    getTranslated(context, ORDER_BY_TXT)!,
                  ),
                  Divider(),
                  CustomBottomSheet.button(
                    context,
                    getTranslated(context, ASC_TXT)!,
                    icon: Icons.sort,
                    onBtnSelected: () {
                      cashCollectionProvider!.cashList.clear();
                      cashCollectionProvider!.offset = 0;
                      cashCollectionProvider!.total = 0;
                      cashCollectionProvider!.isLoading = true;
                      widget.update();
                      cashCollectionProvider!.getOrder(
                        cashCollectionProvider!.currentCashCollectionBy ==
                                "admin"
                            ? "admin"
                            : "delivery",
                        "ASC",
                        widget.update,
                        context,
                      );
                      Navigator.pop(context, 'option 1');
                    },
                  ),
                  CustomBottomSheet.button(
                    context,
                    getTranslated(context, DESC_TXT)!,
                    icon: Icons.sort,
                    onBtnSelected: () {
                      cashCollectionProvider!.cashList.clear();
                      cashCollectionProvider!.offset = 0;
                      cashCollectionProvider!.total = 0;
                      cashCollectionProvider!.isLoading = true;
                      widget.update();
                      cashCollectionProvider!.getOrder(
                        cashCollectionProvider!.currentCashCollectionBy ==
                                "admin"
                            ? "admin"
                            : "delivery",
                        "DESC",
                        widget.update,
                        context,
                      );
                      Navigator.pop(context, 'option 1');
                    },
                  ),
                  Padding(
                    padding: Platform.isIOS
                        ? EdgeInsets.only(bottom: 50)
                        : EdgeInsets.zero,
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: barHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [grad1Color, grad2Color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
          tileMode: TileMode.clamp,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    serachIsEnable
                        ? Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 8.0),
                            child: SizedBox(
                              // height: 60,
                              width: deviceWidth! * 0.7,
                              child: TextField(
                                controller:
                                    cashCollectionProvider!.controllerText,
                                autofocus: true,
                                style: const TextStyle(
                                  color: white,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.search, color: white),
                                  hintText: 'Search...',
                                  hintStyle: const TextStyle(color: white),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: white,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            // height: 36,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 10.0,
                                start: 20,
                                end: 5,
                              ),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  color: white,
                                  fontSize: textFontSize20,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 10, end: 15.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (serachIsEnable == false) {
                                serachIsEnable = true;

                                _handleSearchStart();
                              } else {
                                serachIsEnable = false;
                                cashCollectionProvider!.controllerText.clear();
                                _handleSearchEnd();
                              }
                            });
                          },
                          child: Icon(
                            serachIsEnable ? Icons.close : Icons.search,
                            color: white,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 10, end: 15.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _showBottomSheet();
                                // return GetDialogs.orderSortDialog(
                                //     context, widget.update);
                              },
                              child: Icon(
                                Icons.swap_vert,
                                color: white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
