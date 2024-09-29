import 'package:deliveryboy_multivendor/Widget/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Helper/color.dart';
import '../../../Helper/constant.dart';
import '../../../Localization/Language_Constant.dart';
import '../../../Widget/dialogAnimate.dart';
import '../../../Widget/translateVariable.dart';
import '../../../Widget/validation.dart';
import '../../../main.dart';
import '../home.dart';

class LanguageDialog {
  static languageDialog(
    BuildContext context,
    Function update,
  ) async {
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
                  Center(child: CustomBottomSheet.bottomSheetHandle(context)),
                  CustomBottomSheet.bottomSheetLabel(
                    context,
                    getTranslated(context, ChooseLanguage)!,
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getLngList(context, update),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  static List<Widget> getLngList(
    BuildContext context,
    Function update,
  ) {
    final languageList = [
      getTranslated(context, 'English'),
      getTranslated(context, 'Hindi'),
      getTranslated(context, 'Chinese'),
      getTranslated(context, 'Spanish'),
      getTranslated(context, 'Arabic'),
      getTranslated(context, 'Russian'),
      getTranslated(context, 'Japanese'),
      getTranslated(context, 'Deutch'),
    ];
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            InkWell(
              onTap: () {
                homeProvider!.selectLan = index;
                _changeLan(homeProvider!.langCode[index], context);
                Navigator.of(context).pop();
                update;
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Container(
                        //   height: 25.0,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: homeProvider!.selectLan == index
                        //         ? grad2Color
                        //         : white,
                        //     border: Border.all(color: grad2Color),
                        //   ),
                        // child:
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: homeProvider!.selectLan == index
                              ? const Icon(
                                  Icons.radio_button_checked,
                                  size: 25.0,
                                  color: grad2Color,
                                )
                              : const Icon(
                                  Icons.radio_button_off,
                                  size: 25.0,
                                  color: grad2Color,
                                ),
                        ),

                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 10.0,
                          ),
                          child: Text(
                            languageList[index] ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: lightBlack),
                          ),
                        )
                      ],
                    ),
                    index == languageList.length - 1
                        ? Container(
                            margin: const EdgeInsetsDirectional.only(
                              bottom: 10,
                            ),
                          )
                        : SizedBox(
                            height: 10,
                          )
                  ],
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
  }

  static void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);

    MyApp.setLocale(ctx, _locale);
  }
}
