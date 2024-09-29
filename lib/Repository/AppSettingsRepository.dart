import 'package:deliveryboy_multivendor/Model/appSettingsModel.dart';

//static singleton global class to get sertings
class AppSettingsRepository {
  static AppSettingsModel appSettings = AppSettingsModel(
      isSMSGatewayOn: false,
      isCityWiseDeliveribility: false,
      defaultCountryCode: "IN");
}
