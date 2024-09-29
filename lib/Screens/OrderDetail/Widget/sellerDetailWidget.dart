import 'dart:io';
import 'package:deliveryboy_multivendor/Model/orderModel.dart';
import 'package:deliveryboy_multivendor/Widget/translateVariable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Helper/color.dart';
import '../../../Helper/constant.dart';
import '../../../Model/order_model.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/setSnackbar.dart';
import '../../../Widget/validation.dart';

class SellerDetailsScreen extends StatelessWidget {
  final OrderModel model;
  const SellerDetailsScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  void _launchCaller(
    String phoneNumber,
    BuildContext context,
  ) async {
    var url = "tel:$phoneNumber";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      setSnackbar('Could not launch $url', context);
      throw 'Could not launch $url';
    }
  }

  _launchMap(lat, lng) async {
    var url = '';

    if (Platform.isAndroid) {
      url =
          "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving&dir_action=navigate";
    } else {
      url =
          "http://maps.apple.com/?saddr=&daddr=$lat,$lng&directionsmode=driving&dir_action=navigate";
    }
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 125,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(circularBorderRadius5)),
          color: white,
          boxShadow: const [
            BoxShadow(
                color: blarColor,
                offset: Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5.0, 0, 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, SELLER_DETAILS)!,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize16,
                          ),
                    ),
                    model.sellerDetails!.latitude != "" &&
                            model.sellerDetails!.longitude != ""
                        ? Container(
                            height: 25,
                            child: IconButton(
                              icon: const Icon(
                                Icons.pin_drop_outlined,
                                color: primary,
                                size: 20,
                              ),
                              onPressed: () {
                                _launchMap(model.sellerDetails!.latitude,
                                    model.sellerDetails!.longitude);
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(circularBorderRadius10),
                      child: DesignConfiguration.getCacheNotworkImage(
                        boxFit: BoxFit.cover,
                        context: context,
                        heightvalue: 50,
                        widthvalue: 50,
                        imageurlString: model.sellerDetails!.storeImage!,
                        placeHolderSize: 150,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Text(
                              model.sellerDetails!.storeName != "" &&
                                      model.sellerDetails!.storeName!.isNotEmpty
                                  ? "${StringValidation.capitalize(model.sellerDetails!.storeName!)}"
                                  : " ",
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 1,
                                  ),
                                  child: Text(
                                    StringValidation.capitalize(
                                        model.sellerDetails!.address!),
                                    style: const TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      color: grey3,
                                      fontSize: textFontSize13,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 1,
                              ),
                              child: Row(
                                children: [
                                  // const Icon(
                                  //   Icons.call,
                                  //   size: 15,
                                  //   color: primary,
                                  // ),
                                  Text(
                                    '${getTranslated(context, MOBILEHINT_LBL)} -',
                                    style: const TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      color: grey3,
                                      fontSize: textFontSize13,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 05,
                                  ),
                                  Text(
                                    "${model.sellerDetails!.mobile!}",
                                    style: const TextStyle(
                                      color: primary,
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: textFontSize13,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              _launchCaller(
                                model.sellerDetails!.mobile!,
                                context,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
