class AppSettingsModel {
  bool isSMSGatewayOn;
  bool isCityWiseDeliveribility;
  String defaultCountryCode;
  AppSettingsModel({
    required this.isSMSGatewayOn,
    required this.isCityWiseDeliveribility,
    required this.defaultCountryCode,
  });

  factory AppSettingsModel.fromMap(Map<String, dynamic> data) {
    return AppSettingsModel(
      
      isSMSGatewayOn: data['authentication_settings'] != null &&
              data['authentication_settings'].isNotEmpty
          ? data['authentication_settings']['authentication_method']
                  .toString()
                  .toLowerCase() ==
              'sms'
          : false,
      isCityWiseDeliveribility:
          data['system_settings']['city_wise_deliverability'] == '1',
          defaultCountryCode: data['system_settings']['default_country_code'],
    );
  }
}
