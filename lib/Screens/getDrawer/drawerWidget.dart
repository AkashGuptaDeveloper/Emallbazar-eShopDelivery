import 'package:deliveryboy_multivendor/Screens/Profile/profile.dart';
import 'package:deliveryboy_multivendor/Widget/desing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Helper/color.dart';
import '../../Helper/constant.dart';
import '../../Widget/parameterString.dart';
import '../../Widget/translateVariable.dart';
import '../../Widget/validation.dart';
import '../CashCollection/cash_collection.dart';
import '../Home/Widget/deleteAccountDialog.dart';
import '../Home/Widget/getHeading.dart';
import '../Home/Widget/getLanguageDialog.dart';
import '../Home/Widget/getLogOutDialog.dart';
import '../NotificationList/notification_lIst.dart';
import '../Privacy policy/privacy_policy.dart';
import '../WalletHistory/wallet_history.dart';

class GetDrawerWidget extends StatefulWidget {
  const GetDrawerWidget({Key? key}) : super(key: key);

  @override
  State<GetDrawerWidget> createState() => _GetDrawerWidgetState();
}

class _GetDrawerWidgetState extends State<GetDrawerWidget> {
  Widget _getDivider() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        height: 1,
      ),
    );
  }

  Widget _getDrawerItem(String title, String img) {
    return ListTile(
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(circularBorderRadius100),
        child: Container(
          padding: EdgeInsets.all(8),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: SvgPicture.asset(
            DesignConfiguration.setSvgPath(img),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: black,
          fontSize: textFontSize15,
        ),
      ),
      onTap: () {
        if (title == getTranslated(context, ChangeLanguage)!) {
          LanguageDialog.languageDialog(
            context,
            setState,
          );
        } else if (title == getTranslated(context, EDIT_PROFILE_LBL)!) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Profile(),
            ),
          ).then((_) => setState(() {}));
        } else if (title == getTranslated(context, "Delete Account")!) {
          DeleteAccountDialog.deleteAccountDailog(context, setState);
        } else if (title == getTranslated(context, NOTIFICATION)) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NotificationList(),
            ),
          );
        } else if (title == getTranslated(context, LOGOUT)) {
          LogOutDialog.logOutDailog(context);
        } else if (title == getTranslated(context, PRIVACY)) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => PrivacyPolicy(
                title: getTranslated(context, PRIVACY)!,
              ),
            ),
          );
        } else if (title == getTranslated(context, TERM)) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => PrivacyPolicy(
                title: getTranslated(context, TERM)!,
              ),
            ),
          );
        } else if (title == getTranslated(context, WALLET)) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => WalletHistory(
                isBack: true,
              ),
            ),
          );
        } else if (title == getTranslated(context, CASH_COLL)) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CashCollection(
                isBack: true,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        color: white,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              GetHeading(update: setState),
              SizedBox(
                height: 10,
              ),
              _getDrawerItem(
                  getTranslated(context, EDIT_PROFILE_LBL)!, 'Profile'),
              // _getDrawerItem(
              //   getTranslated(context, WALLET)!,
              //   'wallet'
              // ),
              // _getDrawerItem(
              //   getTranslated(context, CASH_COLL)!,
              //   'coin'
              // ),
              _getDrawerItem(
                  getTranslated(context, ChangeLanguage)!, 'ChangeLanguage'),
              _getDivider(),
              _getDrawerItem(getTranslated(context, PRIVACY)!, 'PrivacyPolicy'),
              _getDrawerItem(getTranslated(context, TERM)!, 'Terms&Conditions'),
              CUR_USERID == "" || CUR_USERID == null
                  ? Container()
                  : _getDivider(),
              CUR_USERID == "" || CUR_USERID == null
                  ? Container()
                  : _getDrawerItem(
                      getTranslated(context, "Delete Account")!, 'Delete'),
              CUR_USERID == "" || CUR_USERID == null
                  ? Container()
                  : _getDrawerItem(getTranslated(context, LOGOUT)!, 'Logout'),
            ],
          ),
        ),
      ),
    );
  }
}
