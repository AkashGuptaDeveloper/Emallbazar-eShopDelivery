import 'dart:async';

import 'dart:io';

import 'package:deliveryboy_multivendor/Helper/constant.dart';
import 'package:deliveryboy_multivendor/Model/city.dart';
import 'package:deliveryboy_multivendor/Provider/cityListProvider.dart';
import 'package:deliveryboy_multivendor/Repository/AppSettingsRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Helper/color.dart';

import '../../Provider/signupProvider.dart';
import '../../Provider/zipcodeListProvider.dart';
import '../../Widget/ButtonDesing.dart';
import '../../Widget/dashedRect.dart';
import '../../Widget/desing.dart';
import '../../Widget/networkAvailablity.dart';
import '../../Widget/parameterString.dart';
import '../../Widget/setSnackbar.dart';
import '../../Widget/translateVariable.dart';
import '../../Widget/validation.dart';
import 'LoginScreen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();
  ScrollController controller = new ScrollController();

  Timer? _debounce;

  bool licenseImageSelected = false;

  List<String> selectedZipcodeList = [];
  List<City> selectedCities = [];

  FocusNode? nameFocus,
      mobileFocus,
      emailFocus,
      passFocus,
      confirmPassFocus,
      addressFocus,
      licenseFocus;

  List<File> licenseImages = [];

  //List<String> licenseGetImages = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;

  bool isShowPass = true;
  bool isShowConfirmPass = true;
  String? commaSeperatedSelectedZipcodesList;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.addListener(_scrollListener);
      if (AppSettingsRepository.appSettings.isCityWiseDeliveribility) {
        context.read<CityListProvider>().getCities();
      } else {
        context.read<ZipcodeListProvider>().getZipcode();
      }
    });
    buttonController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    buttonSqueezeanimation = Tween(
      begin: deviceWidth! * 0.8,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  void dispose() {
    buttonController!.dispose();
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  setStateNow() {
    setState(() {});
  }

  _scrollListener() async {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (mounted) {
        if (AppSettingsRepository.appSettings.isCityWiseDeliveribility) {
          context.read<CityListProvider>().getCities(isReload: false);
        } else {
          context.read<ZipcodeListProvider>().getZipcode(isReload: false);
        }
      }
    }
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      checkNetwork();
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState!;
    form.save();
    if (form.validate() && licenseImageSelected) {
      return true;
    } else if (!licenseImageSelected) {
      setSnackbar(getTranslated(context, 'PLZ_SEL_DRIVING_LICENSE_IMAGES_LBL')!,
          context);
    }
    return false;
  }

  InputDecoration buildInputDecoration(String labelText) {
    return InputDecoration(
      border: InputBorder.none,
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, FocusNode? focusNode,
      String labelText, bool isObscureText, String icon,
      {TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      Widget? suffixIcon,
      bool isEnabled = true,
      String? Function(String?)? validator,
      int? maxErrorLines}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: isObscureText,
        decoration: InputDecoration(
            prefixIcon: SvgPicture.asset(
              DesignConfiguration.setSvgPath(icon),
              fit: BoxFit.scaleDown,
              colorFilter:
                  const ColorFilter.mode(Colors.amber, BlendMode.srcIn),
            ),
            // prefixIconColor: black,
            hintText: getTranslated(context, labelText)!,
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
            suffixIcon: suffixIcon,
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
                  return '${getTranslated(context, 'PLZ_ENTER_LBL')} ${labelText.trim()}';
                }

                // You can add custom validation here if needed
                return null;
              }
            : validator,
      ),
    );
  }

  void _imgFromGallery() async {
    List<XFile>? pickedFileList = await ImagePicker().pickMultiImage(
      maxWidth: 1800,
      maxHeight: 1800,
    );
    licenseImages.clear();
    if (pickedFileList.isNotEmpty) {
      if (pickedFileList.length < 2) {
        setSnackbar(
            getTranslated(context, 'PLZ_ADD_FROND_BACK_IMAGE_MSG')!, context);
      } else if (pickedFileList.length > 2) {
        setSnackbar(getTranslated(context, 'ADD_ONLY_TWO_IMAGES')!, context);
      } else {
        for (int i = 0; i < pickedFileList.length; i++) {
          licenseImages.add(File(pickedFileList[i].path));
        }

        setState(() {
          licenseImageSelected = true; // At least one image is selected.
        });
      }
    }
  }

  Widget getDrivingLicense() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       // color: lightWhite,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: ListTile(
            //       title: Text(getTranslated(context, 'DRIVING_LICENSE_LBL')!),
            //     ),
            //   ),
            // ),

            SizedBox(
              height: 110, // Adjust the height according to your needs
              child: uploadOtherImage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadOtherImage() {
    return licenseImages.isEmpty
        ? InkWell(
            onTap: () {
              _imgFromGallery();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 110,
                  width: deviceWidth! / 2.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(circularBorderRadius7),
                    color: lightWhite,
                  ),
                  child: DashedRect(
                    gap: 2.0,
                    color: lightBlack.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            DesignConfiguration.setSvgPath('Capa')),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 20),
                          child: Text(
                            getTranslated(context, 'FRONT_SIDE_IMAGE_LBL')!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: lightBlack, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 110,
                  width: deviceWidth! / 2.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(circularBorderRadius7),
                    color: lightWhite,
                  ),
                  child: DashedRect(
                    gap: 2.0,
                    color: lightBlack.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            DesignConfiguration.setSvgPath('Capa')),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 20),
                          child: Text(
                            getTranslated(context, 'BACK_SIDE_IMAGE_LBL')!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: lightBlack, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : InkWell(
            onTap: () {
              _imgFromGallery();
            },
            child: SizedBox(
              height: 110,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: licenseImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: index != 0 ? 10 : 0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        licenseImages[index],
                        height: 100.0,
                        fit: BoxFit.fill,
                        width: deviceWidth! / 2.7,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }

  // getLogo() {
  //   return Container(
  //     alignment: Alignment.center,
  //     padding: const EdgeInsets.only(top: 10),
  //     child: SvgPicture.asset(
  //       DesignConfiguration.setNewSvg('loginlogo'),
  //       alignment: Alignment.center,
  //       height: 90,
  //       width: 90,
  //       fit: BoxFit.contain,
  //     ),
  //   );
  // }

  warningMessage() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 5),
      child: AppSettingsRepository.appSettings.isCityWiseDeliveribility
          ? selectedCities.isNotEmpty
              ? SizedBox.shrink()
              : Text(
                  getTranslated(context, 'SELECT_CITIES_REQUIRED_LBL')!,
                  style: TextStyle(color: Colors.red, fontSize: 11),
                )
          : selectedZipcodeList.isNotEmpty
              ? SizedBox.shrink()
              : Text(
                  getTranslated(context, 'PLZ_SEL_AT_LEASE_ONE_ZIPCODES_TXT')!,
                  style: TextStyle(color: Colors.red, fontSize: 11),
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    commaSeperatedSelectedZipcodesList = selectedZipcodeList.join(", ");
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 10,
          left: 23,
          right: 23,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DesignConfiguration.backButton(context),
                Text(
                  getTranslated(context, 'SIGN_UP_LBL')!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                buildTextField(
                  nameController,
                  nameFocus,
                  getTranslated(context, 'FULL_NAME_LBL')!,
                  false,
                  'Profile',
                  validator: (val) => StringValidation.validateUserName(
                    val,
                    context,
                  ),
                ),
                buildTextField(
                  mobileController,
                  mobileFocus,
                  getTranslated(context, 'Mobile number')!,
                  false,
                  'MobileNumber',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val) =>
                      StringValidation.validateMob(val, context),
                ),
                buildTextField(
                  emailController,
                  emailFocus,
                  getTranslated(context, 'EMAIL_LBL')!,
                  false,
                  'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) =>
                      StringValidation.validateEmail(val, context),
                ),
                buildTextField(passwordController, passFocus,
                    getTranslated(context, 'Password')!, isShowPass, 'Password',
                    validator: (val) => StringValidation.validatePass(
                        val, context,
                        onlyRequired: false),
                    maxErrorLines: 4,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isShowPass = !isShowPass;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: Icon(
                          !isShowPass
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black.withOpacity(0.4),
                          size: 22,
                        ),
                      ),
                    )),
                buildTextField(
                    confirmPasswordController,
                    confirmPassFocus,
                    getTranslated(context, 'Confirm Password')!,
                    isShowConfirmPass,
                    'Password', validator: (value) {
                  if (value!.isEmpty) {
                    return getTranslated(context, CON_PASS_REQUIRED_MSG);
                  }
                  if (value != passwordController.text) {
                    return getTranslated(context, CON_PASS_NOT_MATCH_MSG);
                  } else {
                    return null;
                  }
                },
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isShowConfirmPass = !isShowConfirmPass;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: Icon(
                          !isShowConfirmPass
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black.withOpacity(0.4),
                          size: 22,
                        ),
                      ),
                    )),
                buildTextField(addressController, addressFocus,
                    getTranslated(context, 'ADDRESS_LBL')!, false, 'Address'),
                setZipcodeOrCityContainer(),
                warningMessage(),
                SizedBox(height: 6),
                getDrivingLicense(),
                SizedBox(height: 5),
                Center(
                  child: AppBtn(
                    title: getTranslated(context, 'SIGN_UP_LBL')!,
                    btnAnim: buttonSqueezeanimation,
                    btnCntrl: buttonController,
                    onBtnSelected: () async {
                      validateAndSubmit();
                    },
                  ),
                ),
                Center(
                  child: TextButton(
                    child: RichText(
                      text: TextSpan(
                          text:
                              '${getTranslated(context, 'ALREADY_HAVE_AN_ACC_TXT')!} ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                                text: getTranslated(context, 'Sign in')!,
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.normal)),
                          ]),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (context) => Login()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setZipcodeOrCityContainer() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(circularBorderRadius7),
            color: lightWhite.withOpacity(0.5)),
        child: ListTile(
          title: AppSettingsRepository.appSettings.isCityWiseDeliveribility
              ? selectedCities.isNotEmpty
                  ? Text(
                      selectedCities.map((e) => e.name).toList().join(', '),
                    )
                  : Text(
                      getTranslated(context, 'SELECT_CITIES_LBL')!,
                      style: TextStyle(
                          fontSize: 13, color: black.withOpacity(0.4)),
                    )
              : selectedZipcodeList.isNotEmpty
                  ? Text(
                      commaSeperatedSelectedZipcodesList!,
                    )
                  : Text(
                      getTranslated(context, 'SELECT_ZIPCODE_LBL')!,
                      style: TextStyle(
                          fontSize: 13, color: black.withOpacity(0.4)),
                    ),
          trailing: Icon(Icons.chevron_right),
          onTap: () async {
            if (AppSettingsRepository.appSettings.isCityWiseDeliveribility) {
              final cityProvider =
                  Provider.of<CityListProvider>(context, listen: false);
              if (cityProvider.searchString.isNotEmpty) {
                cityProvider.searchString = "";
                context.read<CityListProvider>().getCities();
              } else if (cityProvider.cityList.isEmpty) {
                context.read<CityListProvider>().getCities();
              }
            } else {
              final zipcodeProvider =
                  Provider.of<ZipcodeListProvider>(context, listen: false);
              if (zipcodeProvider.searchString.isNotEmpty) {
                zipcodeProvider.searchString = "";
                context.read<ZipcodeListProvider>().getZipcode();
              } else if (zipcodeProvider.zipcodeList.isEmpty) {
                context.read<ZipcodeListProvider>().getZipcode();
              }
            }
            await showDialog(
              context: context,
              builder: (BuildContext buildContext) {
                return AlertDialog(
                  scrollable: true,
                  content: Consumer<CityListProvider>(
                    builder: (context, cityData, child) {
                      return Consumer<ZipcodeListProvider>(
                        builder: (context, data, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                getTranslated(
                                    context,
                                    AppSettingsRepository.appSettings
                                            .isCityWiseDeliveribility
                                        ? 'SELECT_CITIES_LBL'
                                        : 'SELECT_SERVICEABLE_ZIPCODE_LBL')!,
                                style: Theme.of(this.context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: primary),
                              ),
                              const Divider(color: lightBlack),
                              Flexible(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: SingleChildScrollView(
                                    // physics: AlwaysScrollableScrollPhysics(),
                                    controller: controller,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    circularBorderRadius5)),
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
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              isDense: true,
                                              fillColor: white,
                                              prefixIconConstraints:
                                                  const BoxConstraints(
                                                minWidth: 40,
                                                maxHeight: 20,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              hintText: getTranslated(
                                                  context, "SEARCH"),
                                              hintStyle: TextStyle(
                                                  color: black.withOpacity(0.3),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              if (_debounce?.isActive ?? false)
                                                _debounce?.cancel();
                                              data.searchString = value;
                                              cityData.searchString = value;
                                              //auto search after 1 second of typing
                                              _debounce = Timer(
                                                  const Duration(
                                                      milliseconds: 1000), () {
                                                if (AppSettingsRepository
                                                    .appSettings
                                                    .isCityWiseDeliveribility) {
                                                  context
                                                      .read<CityListProvider>()
                                                      .getCities();
                                                } else {
                                                  context
                                                      .read<
                                                          ZipcodeListProvider>()
                                                      .getZipcode();
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        (AppSettingsRepository.appSettings
                                                    .isCityWiseDeliveribility
                                                ? cityData.isLoading
                                                : data.isLoading)
                                            ? const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 50.0),
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  (AppSettingsRepository
                                                              .appSettings
                                                              .isCityWiseDeliveribility
                                                          ? cityData.cityList
                                                              .isNotEmpty
                                                          : data.zipcodeList
                                                              .isNotEmpty)
                                                      ? StatefulBuilder(builder:
                                                          (context, setstater) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: () {
                                                              if (AppSettingsRepository
                                                                  .appSettings
                                                                  .isCityWiseDeliveribility) {
                                                                return cityData
                                                                    .cityList
                                                                    .asMap()
                                                                    .map((index,
                                                                            element) =>
                                                                        MapEntry(
                                                                            index,
                                                                            CheckboxListTile(
                                                                              title: Text(element.name),
                                                                              value: selectedCities.contains(element),
                                                                              onChanged: (_) {
                                                                                if (selectedCities.contains(element)) {
                                                                                  selectedCities.remove(element);
                                                                                } else {
                                                                                  selectedCities.add(element);
                                                                                }
                                                                                setState(() {});
                                                                                setstater(() {});
                                                                              },
                                                                            )))
                                                                    .values
                                                                    .toList();
                                                              }
                                                              return data
                                                                  .zipcodeList
                                                                  .asMap()
                                                                  .map((index,
                                                                          element) =>
                                                                      MapEntry(
                                                                          index,
                                                                          CheckboxListTile(
                                                                            title:
                                                                                Text(element.zipcode!),
                                                                            value:
                                                                                selectedZipcodeList.contains(element.zipcode),
                                                                            //value: true,
                                                                            onChanged:
                                                                                (_) {
                                                                              if (selectedZipcodeList.contains(element.zipcode)) {
                                                                                selectedZipcodeList.remove(element.zipcode);
                                                                              } else {
                                                                                selectedZipcodeList.add(element.zipcode!);
                                                                              }
                                                                              setState(() {});
                                                                              setstater(() {});
                                                                            },
                                                                          )))
                                                                  .values
                                                                  .toList();
                                                            }(),
                                                          );
                                                        })
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      20.0),
                                                          child: Text(getTranslated(
                                                              context,
                                                              AppSettingsRepository
                                                                      .appSettings
                                                                      .isCityWiseDeliveribility
                                                                  ? 'CITY_IS_NOT_AVAIL_LBL'
                                                                  : 'ZIPCODE_IS_NOT_AVAIL_LBL')!),
                                                        ),
                                                  DesignConfiguration
                                                      .showCircularProgress(
                                                    AppSettingsRepository
                                                            .appSettings
                                                            .isCityWiseDeliveribility
                                                        ? cityData.isLoadingmore
                                                        : data.isLoadingmore,
                                                    primary,
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    getTranslated(context, 'DONE')!,
                                    style: Theme.of(this.context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: primary),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> checkNetwork() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      if (selectedCities.isNotEmpty || selectedZipcodeList.isNotEmpty) {
        Future.delayed(Duration.zero).then(
          (value) => context
              .read<SignupAuthenticationProvider>()
              .getSignupData(
                  address: addressController.text.trim(),
                  confirmPass: confirmPasswordController.text.trim(),
                  email: emailController.text.trim(),
                  context: context,
                  licenses: licenseImages,
                  mobile: mobileController.text.trim(),
                  name: nameController.text.trim(),
                  password: passwordController.text.trim(),
                  serviceableCities:
                      selectedCities.map((e) => e.id).toList().join(','),
                  zipcodes: commaSeperatedSelectedZipcodesList ?? "")
              .then(
            (
              value,
            ) async {
              print("value****$value");
              bool error = value["error"];
              String? msg = value["message"];

              await buttonController!.reverse();
              if (!error) {
                setSnackbar(msg!, context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              } else {
                setSnackbar(msg!, context);
              }
            },
          ),
        );
      } else {
        await buttonController!.reverse();
        if (AppSettingsRepository.appSettings.isCityWiseDeliveribility) {
          setSnackbar(
              getTranslated(context, 'SELECT_CITIES_REQUIRED_LBL')!, context);
        } else {
          setSnackbar(
              getTranslated(context, 'PLZ_SEL_AT_LEASE_ONE_ZIPCODES_TXT')!,
              context);
        }
      }
    } else {
      Future.delayed(Duration(seconds: 2)).then(
        (_) async {
          await buttonController!.reverse();
          setState(
            () {
              isNetworkAvail = false;
            },
          );
        },
      );
    }
  }
}
