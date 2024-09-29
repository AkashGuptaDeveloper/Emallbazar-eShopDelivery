import 'dart:async';
import 'package:deliveryboy_multivendor/Model/orderModel.dart';
import 'package:flutter/material.dart';
import '../Model/order_model.dart';
import '../Repository/orderDetailRepositry.dart';
import '../Widget/networkAvailablity.dart';
import '../Widget/parameterString.dart';
import '../Widget/setSnackbar.dart';
import '../Widget/translateVariable.dart';
import '../Widget/validation.dart';

class OrderDetailProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller = ScrollController();
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  List<String> statusList = [
    PLACED,
    PROCESSED,
    SHIPED,
    DELIVERD,
    CANCLED,
    RETURNED,
    WAITING,
    /* 'return_request_pending',
    'return_request_approved',
    'return_request_decline'*/
  ];
  bool? isCancleable, isReturnable, isLoading = true;
  bool isProgress = false;
  String? curStatus;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController? otpC;

  initializeVariable() {
    statusList = [
      PLACED,
      PROCESSED,
      SHIPED,
      DELIVERD,
      CANCLED,
      RETURNED,
      WAITING,
      /* 'return_request_pending',
      'return_request_approved',
      'return_request_decline'*/
    ];
    isCancleable = null;
    isReturnable = null;
    isLoading = true;
    isProgress = false;
    curStatus = null;
    if (otpC != null) {
      otpC!.clear();
    }
  }

  Future<void> updateOrder(String? status, String? consignmentId, String? otp,
      Function update, BuildContext context, OrderModel model) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      try {
        isProgress = true;
        update();
        var parameter = {
          'consignment_id': consignmentId,
          STATUS: status,
          OTP: otp == 0 ? "" : otp,
        };

        var getdata = await UpdateOrderConsignmentStatus.updateOrderIteam(
          parameter: parameter,
        );

        bool error = getdata["error"];
        String msg = getdata["message"];
        setSnackbar(msg, context);
        if (!error) {
          model.activeStatus = status;
        }
        isProgress = false;
        update();
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, somethingMSg)!, context);
      }
    } else {
      isNetworkAvail = false;
      update();
    }
  }
}
