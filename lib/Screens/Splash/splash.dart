import 'dart:async';
import 'package:deliveryboy_multivendor/Helper/color.dart';
import 'package:deliveryboy_multivendor/Model/appSettingsModel.dart';
import 'package:deliveryboy_multivendor/Repository/AppSettingsRepository.dart';
import 'package:deliveryboy_multivendor/Repository/SystemRepository.dart';
import 'package:deliveryboy_multivendor/Widget/desing.dart';
import 'package:deliveryboy_multivendor/Widget/errorContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Provider/SettingsProvider.dart';
import '../../Widget/parameterString.dart';
import '../../Widget/systemChromeSettings.dart';
import '../Authentication/LoginScreen.dart';
import '../DeshBord/deshBord.dart';

//splash screen of app
class Splash extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isFirstTime = false;
  bool isError = false;
  String errorMessage = '';
  @override
  void initState() {
    SystemChromeSettings.setSystemButtomNavigationonlyTop();
    SystemChromeSettings.setSystemUIOverlayStyleWithLightBrightNessStyle();
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: isError
          ? Center(
              child: ErrorContainer(
                  onTapRetry: () {
                    getSettings();
                  },
                  errorMessage: errorMessage),
            )
          : Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: DesignConfiguration.back(),
                  child: Center(
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: lightWhite,
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: SvgPicture.asset(
                        DesignConfiguration.setSvgPath('loginlogo'),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  DesignConfiguration.setPngPath('doodle'),
                  // fit: BoxFit.fill,
                  // width: double.infinity,
                  // height: double.infinity,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: SvgPicture.asset(
                          DesignConfiguration.setSvgPath('Brandlogo'),
                          // fit: BoxFit.fill,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  getSettings() async {
    if (isError) {
      isError = false;
      setState(() {});
    }
    try {
      final data = await SystemRepository.fetchSystemSettings();
      AppSettingsRepository.appSettings = AppSettingsModel.fromMap(data);
      navigationPage();
    } catch (e) {
      isError = true;
      errorMessage = e.toString();
      setState(() {});
    }
  }

  Future<void> navigationPage() async {
    SettingProvider settingProvider =
        Provider.of<SettingProvider>(context, listen: false);
    isFirstTime = await settingProvider.getPrefrenceBool(isLogin);
    if (isFirstTime) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  void dispose() {
    SystemChromeSettings.setSystemButtomNavigationBarithTopAndButtom();
    if (isFirstTime) {
      SystemChromeSettings.setSystemUIOverlayStyleWithLightBrightNessStyle();
    } else {
      SystemChromeSettings.setSystemUIOverlayStyleWithDarkBrightNessStyle();
    }
    super.dispose();
  }
}
