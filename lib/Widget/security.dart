import 'package:deliveryboy_multivendor/main.dart';

Map<String, String>? get headers {
  final String? token = globalSettingsProvider?.token; print("THERE: ${token}");
  if (token != null && token.toString().trim().isNotEmpty) {
    return {
      'Authorization': 'Bearer $token',
    };
  }
  return null;
}
