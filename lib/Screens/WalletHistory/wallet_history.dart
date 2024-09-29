import 'dart:async';
import 'dart:io';
import 'package:deliveryboy_multivendor/Helper/color.dart';
import 'package:deliveryboy_multivendor/Provider/WalletProvider.dart';
import 'package:deliveryboy_multivendor/Screens/WalletHistory/Widget/GetDialogs.dart';
import 'package:deliveryboy_multivendor/Screens/WalletHistory/Widget/button.dart';
import 'package:deliveryboy_multivendor/Widget/appBar.dart';
import 'package:deliveryboy_multivendor/Widget/bottomsheet.dart';
import 'package:deliveryboy_multivendor/Widget/setSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Helper/constant.dart';
import '../../Widget/ButtonDesing.dart';
import '../../Widget/desing.dart';
import '../../Widget/networkAvailablity.dart';
import '../../Widget/noNetwork.dart';
import '../../Widget/parameterString.dart';
import '../../Widget/simmerEffect.dart';
import '../../Widget/translateVariable.dart';
import '../../Widget/validation.dart';
import 'Widget/ListItem.dart';

class WalletHistory extends StatefulWidget {
  final bool isBack;

  const WalletHistory({Key? key, required this.isBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return StateWallet();
  }
}

class StateWallet extends State<WalletHistory> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ScrollController controller = ScrollController();
  TextEditingController? amtC, bankDetailC, acc_num, ifsc_code, acc_name;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    print("-----------------initState ");
    // Future.delayed(Duration.zero, () async {
    //   context.read<MyWalletProvider>().getUserWalletTransactions(
    //       context: context, walletTransactionIsLoadingMore: true);
    // });
    _tabController = TabController(length: 2, vsync: this);

    getwallethistory();
    // _tabController?.index = 0;
    controller.addListener(_scrollListener);
    buttonController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    buttonSqueezeanimation = Tween(
      begin: deviceWidth! * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: Interval(
          0.0,
          0.150,
        ),
      ),
    );
    amtC = TextEditingController();
    bankDetailC = TextEditingController();
    acc_num = TextEditingController();
    ifsc_code = TextEditingController();
    acc_name = TextEditingController();
  }

  @override
  void dispose() {
    // buttonController!.dispose();
    // _tabController!.dispose();
    super.dispose();
  }

  getwallethistory() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_tabController?.index == 0) {
        context.read<MyWalletProvider>().walletTransactionList.clear();
        context.read<MyWalletProvider>().transactionListOffset = 0;
        context.read<MyWalletProvider>().transactionListTotal = 0;
        context.read<MyWalletProvider>().isLoading = true;

        context.read<MyWalletProvider>().getUserWalletTransactions(
            context: context, walletTransactionIsLoadingMore: true);
        print('---------index: ${_tabController?.index}');
      } else {
        context.read<MyWalletProvider>().walletTransactionList.clear();
        context.read<MyWalletProvider>().transactionListOffset = 0;
        context.read<MyWalletProvider>().transactionListTotal = 0;
        context.read<MyWalletProvider>().isLoading = true;
        context
            .read<MyWalletProvider>()
            .fetchUserWalletAmountWithdrawalRequestTransactions(
                context: context, walletTransactionIsLoadingMore: true);
        print('---------index: ${_tabController?.index}');
      }
    });
  }

  getAppBar() {
    return Container(
      decoration: const BoxDecoration(
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
            Opacity(
              opacity: 0.17000000178813934,
              child: Container(
                  width: deviceWidth! * 0.9,
                  height: 1,
                  decoration: const BoxDecoration(color: white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: widget.isBack
                      ? InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Padding(
                            padding: EdgeInsetsDirectional.only(start: 15.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: white,
                              size: 25,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 15,
                        ),
                ),
                Container(
                  height: 36,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 9.0,
                      /*  start: 15,
                      end: 15, */
                    ),
                    child: Text(
                      getTranslated(context, WALLET)!,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        color: white,
                        fontSize: textFontSize16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 15.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            return GetDialogs.filterDialog(context);
                          },
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getfilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circularBorderRadius5),
            color: white),
        child: InkWell(
          child: TabBar(
              onTap: (index) async {
                {
                  await getwallethistory();
                }
              },
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.all(8),
              labelPadding: EdgeInsets.zero,
              unselectedLabelStyle:
                  Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: black,
                        fontWeight: FontWeight.normal,
                      ),
              labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              controller: _tabController,
              indicator: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(circularBorderRadius5)),
              tabs: [
                CommanButton(
                  selected: _tabController?.index == 0 ? true : false,
                  title: getTranslated(context, SHOW_TRANS)!,
                ),
                CommanButton(
                  selected: _tabController?.index == 1 ? true : false,
                  title: getTranslated(context, SHOW_REQ)!,
                ),
              ]),
        ),
      ),
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
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Center(child: CustomBottomSheet.bottomSheetHandle(context)),
                    CustomBottomSheet.bottomSheetLabel(
                      context,
                      getTranslated(context, SEND_REQUEST)!,
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            getTranslated(context, WITHDRWAL_AMT)!,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(),
                          ),
                        ),
                        buildTextField(amtC,
                            getTranslated(context, WITHDRAW_AMOUNT)!, false,
                            validator: (value) =>
                                validateField(value, context)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: Text(
                            getTranslated(context, BANK_DETAIL)!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        CustomBottomSheet.bottomSheetText(
                            context, getTranslated(context, "BK_NAME")!),
                        buildTextField(
                          acc_name,
                          getTranslated(context, ACC_NAME)!,
                          false,
                          validator: (value) => validateField(value, context),
                        ),
                        CustomBottomSheet.bottomSheetText(
                            context, getTranslated(context, "Account Number")!),
                        buildTextField(
                          acc_num,
                          getTranslated(context, ACC_NUMBER),
                          false,
                          validator: (value) => validateField(value, context),
                        ),
                        CustomBottomSheet.bottomSheetText(
                            context, getTranslated(context, "IFSC Code")!),
                        buildTextField(
                          ifsc_code,
                          getTranslated(context, ACC_IFSC),
                          false,
                          validator: (value) => validateField(value, context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AppBtn(
                              width: MediaQuery.of(context).size.width / 2.3,
                              title: getTranslated(context, CANCEL)!,
                              btnAnim: buttonSqueezeanimation,
                              btnCntrl: buttonController,
                              color: white,
                              textcolor: black,
                              onBtnSelected: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          AppBtn(
                            width: MediaQuery.of(context).size.width / 2.3,
                            title: getTranslated(context, SEND_LBL)!,
                            btnAnim: buttonSqueezeanimation,
                            btnCntrl: buttonController,
                            onBtnSelected: () async {
                              final form = _formkey.currentState!;
                              if (form.validate()) {
                                form.save();

                                context
                                    .read<MyWalletProvider>()
                                    .sendAmountWithdrawRequest(
                                        userID: CUR_USERID!,
                                        bankDetails:
                                            "${acc_num?.text.toString()}\n${ifsc_code?.text.toString()}\n${acc_name?.text.toString()}",
                                        withdrawalAmount: amtC!.text.toString())
                                    .then((value) {
                                  print("value =  ${value['message']}");
                                  form.reset;
                                  setSnackbar(value['message'], context);
                                  getwallethistory();
                                  Navigator.pop(context);
                                  // setSnackbar(value['message'], context);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: Platform.isIOS
                          ? EdgeInsets.only(bottom: 50)
                          : EdgeInsets.zero,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildTextField(
      TextEditingController? controller, String? labelText, bool isObscureText,
      {TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      Widget? preIcon,
      bool? isEnabled,
      Function(String)? onchanged,
      String? Function(String?)? validator,
      int? maxErrorLines}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: isObscureText,
        decoration: InputDecoration(
            // prefixIcon: SvgPicture.asset(
            //   DesignConfiguration.setEditProfileScreenSvg(icon),
            //   fit: BoxFit.scaleDown,
            //   colorFilter:
            //       const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            // ),
            // prefixIconColor: black,
            hintText: labelText,
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: lightBlack2,
                  fontWeight: FontWeight.normal,
                ),
            filled: true,
            fillColor: lightWhite.withOpacity(0.4),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            errorMaxLines: maxErrorLines,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              maxHeight: 20,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(circularBorderRadius7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(circularBorderRadius7),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(circularBorderRadius7),
            ),
            border: InputBorder.none),

        // buildInputDecoration(labelText).copyWith(
        //     errorMaxLines: maxErrorLines,
        //     suffixIcon: suffixIcon,
        //     fillColor: lightWhite,
        //     filled: true,
        //     border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //         borderSide: BorderSide.none)),
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        enabled: isEnabled,
        validator: validator == null
            ? (val) {
                if (val == null || val.isEmpty) {
                  return '${getTranslated(context, 'PLZ_ENTER_LBL')} ${labelText?.trim()}';
                }

                // You can add custom validation here if needed
                return null;
              }
            : validator,
        onChanged: onchanged,
      ),
    );
  }

  getBalanceShower() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    color: primary,
                  ),
                  Text(
                    " " + CURBAL_LBL,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text(
                  DesignConfiguration.getPriceFormat(
                      context, double.parse(CUR_BALANCE))!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: black, fontWeight: FontWeight.bold)),
              AppBtn(
                title: getTranslated(context, WITHDRAW_MONEY)!,
                btnAnim: buttonSqueezeanimation,
                btnCntrl: buttonController,
                onBtnSelected: () {
                  _showBottomSheet();
                },
              )
              // SimBtn(
              //   sizePercentage: 0.8,
              //   title: getTranslated(context, WITHDRAW_MONEY)!,
              //   onBtnSelected: () {
              //     // GetDialogs.withDrawMonetDiolog(context, amtC, acc_num,
              //     //     ifsc_code, acc_name, bankDetailC, _formkey);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightWhite,
        key: _scaffoldKey,
        appBar: GradientAppBar(
          getTranslated(context, WALLET)!,
          customback: false,
        ),
        // appBar: GetAppBar.getAppBar(
        //   getTranslated(context, WALLET)!,
        //   context,
        // ),
        body: isNetworkAvail
            ? Consumer<MyWalletProvider>(
                builder: (context, value, child) {
                  if (value.getCurrentStatus == MyWalletStatus.isFailure) {
                    return Column(
                      children: [
                        // GradientAppBar(
                        //   getTranslated(context, WALLET)!,
                        //   customback: false,
                        // ),
                        Center(
                          child: Text(
                            value.errorMessage,
                          ),
                        ),
                      ],
                    );
                  } else if (value.getCurrentStatus ==
                      MyWalletStatus.isSuccsess) {
                    return RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: _refresh,
                      child: SingleChildScrollView(
                        controller: controller,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(children: [
                          // GradientAppBar(
                          //   getTranslated(context, WALLET)!,
                          //   customback: false,
                          // ),
                          getBalanceShower(),
                          getfilters(),
                          value.walletTransactionList.isEmpty
                              ? Container(
                                  height: deviceHeight * 0.5,
                                  child: Center(
                                    child: Text(
                                      getTranslated(context, noItem)!,
                                    ),
                                  ),
                                )
                              : MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: (value.transactionListOffset <
                                            value.transactionListTotal)
                                        ? value.walletTransactionList.length + 1
                                        : value.walletTransactionList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return (index ==
                                                  value.walletTransactionList
                                                      .length &&
                                              value
                                                  .walletTransactionHasMoreData)
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListItem(
                                              index: index,
                                              model: value
                                                  .walletTransactionList[index],
                                            );
                                    },
                                  ),
                                ),
                        ]),
                      ),
                    );
                  }
                  return const ShimmerEffect();
                },
              )
            : noInternet(
                context,
                setStateNoInternate,
                buttonSqueezeanimation,
                buttonController,
              ));
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  setStateNoInternate() async {
    _playAnimation();
    Future.delayed(Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          // getTransaction();
        } else {
          await buttonController!.reverse();
          setState(
            () {},
          );
        }
      },
    );
  }

  Future<void> _refresh() async {
    getwallethistory();
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (this.mounted) {
        setState(
          () {
            if (context.read<MyWalletProvider>().transactionListOffset <
                context.read<MyWalletProvider>().transactionListTotal)
              context.read<MyWalletProvider>().getUserWalletTransactions(
                  context: context, walletTransactionIsLoadingMore: true);
          },
        );
      }
    }
  }
}
