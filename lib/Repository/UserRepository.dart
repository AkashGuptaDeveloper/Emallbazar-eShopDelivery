import 'dart:convert';
import 'dart:core';
import 'package:deliveryboy_multivendor/Widget/security.dart';
import 'package:http/http.dart';

import '../Helper/ApiBaseHelper.dart';
import '../Widget/api.dart';
import '../Widget/parameterString.dart';
import '../Widget/translateVariable.dart';

class UserRepository {
  //This method is used to update user profile
  static Future<Map<String, dynamic>> updateUser(
      {
      // required String userID,
      oldPwd,
      newPwd,
      username,
      userEmail,
      licenses}) async {
    try {
      // var data = {

      //   // USER_ID: userID,
      //   USERNAME: username,
      //   EMAIL: userEmail,
      // };
      var request = MultipartRequest("POST", getUpdateUserApi);
      request.headers.addAll(headers ?? {});
      request.fields[USERNAME] = username;
      request.fields[EMAIL] = userEmail;
      if (licenses.isNotEmpty) {
        for (var i = 0; i < licenses.length; i++) {
          var pic = await MultipartFile.fromPath(
            DRIVING_LICENSE_OTHER,
            licenses[i].path,
          );
          request.files.add(pic);
        }
      }
      // if ((oldPwd != null) && (newPwd != null)) {
      //   data[OLDPASS] = oldPwd;
      //   data[NEWPASS] = newPwd;
      // }
      if ((oldPwd != null) && (newPwd != null)) {
        request.fields['old'] = oldPwd;
        request.fields['new'] = newPwd;
      }
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      var getdata = json.decode(responseString);
      // final result = await ApiBaseHelper().postAPICall(getUpdateUserApi, data);

      bool error = getdata["error"];
      String msg = getdata['message'];
      if(getdata[DRIVING_LICENSE]!=null){
      List driving_license = getdata[DRIVING_LICENSE];
      return {
        'error': error,
        'message': msg,
        'driving_license': driving_license
      };}
      else{
        return {
        'error': error,
        'message': msg
      };
      }
    } catch (e) {
      throw ApiException('$somethingMSg,${e.toString()}');
    }
  }
}
