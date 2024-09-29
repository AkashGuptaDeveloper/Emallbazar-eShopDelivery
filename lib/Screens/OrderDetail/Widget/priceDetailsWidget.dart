import 'package:deliveryboy_multivendor/Model/orderModel.dart';
import 'package:flutter/material.dart';
import '../../../Helper/color.dart';
import '../../../Helper/constant.dart';
import '../../../Model/order_model.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/translateVariable.dart';
import '../../../Widget/validation.dart';

class PriceDetails extends StatelessWidget {
  final OrderModel model;
  const PriceDetails({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
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
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, PRICE_DETAIL)!,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: black,
                      fontWeight: FontWeight.w400,
                      fontFamily: "PlusJakartaSans",
                      fontStyle: FontStyle.normal,
                      fontSize: textFontSize16,
                    ),
              ),
              const Divider(
                color: grey3,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, PRICE_LBL)! + " :",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                    Text(
                      "${DesignConfiguration.getPriceFormat(context, double.parse(model.total!))!}",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, DELIVERY_CHARGE_LBL)! + " :",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                    Text(
                      "+ ${DesignConfiguration.getPriceFormat(
                        context,
                        double.parse(model.deliveryCharge!),
                      )!}",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, TAXPER)! +
                          " (${model.taxPercent!}%) :",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                    Text(
                      "+ ${DesignConfiguration.getPriceFormat(context, double.parse(model.taxAmount!))!}",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, PROMO_CODE_DIS_LBL)! + " :",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                    Text(
                      "- ${DesignConfiguration.getPriceFormat(context, double.parse(model.promoDiscount!))!}",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, WALLET_BAL)! + " :",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                    Text(
                      "- ${DesignConfiguration.getPriceFormat(context, double.parse(model.walletBalance!))!}",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, TOTAL_PRICE)! + " :",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: grey3,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PlusJakartaSans",
                          fontStyle: FontStyle.normal,
                          fontSize: textFontSize12,
                        ),
                  ),
                  Text(
                    "${DesignConfiguration.getPriceFormat(context, double.parse(model.total!))!}",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PlusJakartaSans",
                          fontStyle: FontStyle.normal,
                          fontSize: textFontSize12,
                        ),
                  )
                ],
              ),
              Divider(
                color: grey3,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, PAYABLE)! + ": ",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    ),
                    Text(
                      "${DesignConfiguration.getPriceFormat(context, double.parse(model.totalPayable!))!}",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: textFontSize12,
                          ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
