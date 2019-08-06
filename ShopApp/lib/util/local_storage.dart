import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Utility method to retrieve the saved JWT token
Future<String> getAuthToken() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");
  return "Bearer " + token;
}

void setAuthToken(String token) async {
  final storage = new FlutterSecureStorage();
  await storage.write(key: "token", value: token);
}
