import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:love_novel/app/global/remote_config.dart';

class AppSources {
  static late String apiUrl;
  static late String privateKey;
  static late String apiKey;

  static bool inited = false;
  static Future load() async {
    if (!inited) {
      await dotenv.load(fileName: ".env");
      apiUrl = dotenv.env['API_URL'].toString();
      if (Platform.isAndroid) {
        privateKey = dotenv.env['AND_PRIVATE_KEY'].toString();
        apiKey = dotenv.env['AND_API_KEY'].toString();
      } else if (Platform.isIOS) {
        privateKey = dotenv.env['IOS_PRIVATE_KEY'].toString();
        apiKey = dotenv.env['IOS_API_KEY'].toString();
      } else {
        throw UnsupportedError("Unsupported platform");
      }
      inited = true;
    }
  }
}
