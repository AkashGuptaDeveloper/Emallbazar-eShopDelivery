import 'package:flutter/material.dart';
import '../../../Helper/color.dart';
import '../../../Helper/constant.dart';
import '../../../Model/transaction_model.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/translateVariable.dart';
import '../../../Widget/validation.dart';

class ListItem extends StatelessWidget {
  final int index;
  final TransactionModel model;

  ListItem({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color back;
    if (model.status == "success" || model.status == ACCEPTED) {
      back = Colors.green;
    } else if (model.status == PENDING)
      back = Colors.orange;
    else
      back = Colors.red;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(circularBorderRadius5)),
          boxShadow: const [
            BoxShadow(
              color: blarColor,
              offset: Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
          color: white,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(circularBorderRadius5),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, ID_LBL)! + " : " + model.id!,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: back,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(
                            circularBorderRadius5,
                          ),
                        ),
                      ),
                      child: Text(
                        StringValidation.capitalize(
                          model.status!,
                        ),
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Date" + " : " + model.date!,
                ),
                model.opnBal != "" &&
                        model.opnBal != null &&
                        model.opnBal!.isNotEmpty
                    ? Text(
                        getTranslated(context, OPNBL_LBL)! +
                            " : " +
                            model.opnBal!,
                      )
                    : Container(),
                model.clsBal != "" &&
                        model.clsBal != null &&
                        model.clsBal!.isNotEmpty
                    ? Text(
                        CLBL_LBL + " : " + model.clsBal!,
                      )
                    : Container(),
                model.msg != "" && model.msg != null && model.msg!.isNotEmpty
                    ? Text(
                        MSG_LBL + " : " + model.msg!,
                      )
                    : Container(),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, AMT_LBL)!,
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        color: black,
                        fontSize: textFontSize16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      DesignConfiguration.getPriceFormat(
                          context, double.parse(model.amt!))!,
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        color: black,
                        fontSize: textFontSize16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
