import 'dart:async';
import 'package:flutter/material.dart';
import '../Helper/constant.dart';
import '../Model/zipcodeModel.dart';
import '../Repository/zipcodeRepository.dart';
import '../Widget/parameterString.dart';

class ZipcodeListProvider extends ChangeNotifier {
  List<Zipcode_Model> zipcodeList = [];
  int offset = 0;
  int total = 0;
  bool isLoadingmore = false;
  bool isLoading = true;
  bool isError = false;
  bool isLoadingMoreError = false;
  String searchString = '';
  String errorString = '';

  Future<void> getZipcode({bool isReload = true}) async {
    if (isLoadingmore == true || (offset >= total && !isReload)) {
      return;
    }
    if (isReload) {
      zipcodeList.clear();
      offset = 0;
      isLoading = true;
    } else {
      isLoadingmore = true;
    }
    notifyListeners();

    try {
      var parameter = {
        LIMIT: perPage.toString(),
        OFFSET: offset.toString(),
        if (searchString.trim().isNotEmpty) SEARCH: searchString,
      };
      var getdata = await ZipcodeListRepository.getZipcodes(
        parameter: parameter,
      );
      bool error = getdata["error"];
      if (!error) {
        total = int.parse(getdata["total"].toString());
        if ((offset) < total) {
          var data = getdata["data"];
          zipcodeList.addAll((data as List)
              .map(
                (data) => Zipcode_Model.fromJson(data),
              )
              .toList());
          offset = offset + perPage;
        }
      }
    } catch (e) {
      errorString = e.toString();
      if (isReload) {
        isError = true;
      } else {
        isLoadingMoreError = true;
      }
    }

    if (isReload) {
      isLoading = false;
    } else {
      isLoadingmore = false;
    }
    notifyListeners();
  }
}
