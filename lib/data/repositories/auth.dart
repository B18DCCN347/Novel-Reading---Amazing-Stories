import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/app_navigator.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/sources.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/apis/auth.dart';
import 'package:love_novel/data/apis/base.dart';
import 'package:love_novel/data/models/request/auth_result.dart';
import 'package:love_novel/data/models/request/validate_token_result.dart';
import 'package:love_novel/ui/pages/account/login/login.dart';
import 'package:love_novel/ui/pages/account/register/register.dart';
import 'package:love_novel/ui/pages/home/home.dart';
import 'package:love_novel/ui/pages/menu/controller.dart';

class TokenInfo {
  String? token;
  String? userId;
  TokenInfo({this.token, this.userId});
}

abstract class IAuthRepository{
  
}

class AuthRepository {
  AuthApi api = API.getAuthApi();

  static int? serverTimestamp;
  Future<AuthResult?> getTokenAsAnonymous() async {
    var userId = await storage.read(key: USER_KEY);
    if (userId == null) {
      userId = (await api.registerAnonymous(AppSources.apiKey))?.uuid ?? "";
      await storage.write(key: USER_KEY, value: userId);
    }
    var response =
        await api.token(AppSources.apiKey, userId).catchError((error) {
      debugPrint(error.toString());
    });
    MenuController.customerId.value = response?.uuid ?? "Unknown";
    return response;
  }

  Future<ValidateTokenResult?> validateToken() async {
    var token = await AuthRepository().getTokenFromStorage();
    if ((token ?? "").isEmpty) return null;
    var sig = AuthRepository().buildSig([]);
    try {
      var response = await api
          .validateToken(token!, AppSources.apiKey, sig)
          .catchError((error) {
        debugPrint(error.toString());
      });
      MenuController.customerId.value = response?.customer?.uuid ?? "Unknown";
      return response;
    } catch (e) {
      return null;
    }
  }

  static const storage = FlutterSecureStorage();

  final TOKEN_KEY = "__TOKEN_KEY__";
  final USER_INFO_KEY = "__USER_INFO_KEY__";
  final USER_KEY = "__USER_KEY__";

  Future<AuthResult?> loginAsAnonymous() async {
    var result = await getTokenAsAnonymous();
    await storage.delete(key: TOKEN_KEY);
    if (result?.token != null) {
      await storage.write(key: TOKEN_KEY, value: result?.token);
    }
    return result;
  }

  Future<dynamic> logout() async {
    await clearSession();
    if (AppController.currentRoute.value != LoginPage.route &&
        AppController.currentRoute.value != RegisterPage.route) {
      await Get.offNamedUntil(LoginPage.route, (route) => false);
    }
  }

  static var _tokenLoading = false;

  Future<TokenInfo> getToken() async {
    try {
      var token = await storage.read(key: TOKEN_KEY);
      if ((token ?? "").isNotEmpty) {
        try {
          var response = await validateToken().catchError((error) {});
          if (response == null) {
            await clearToken();
            token = null;
          }
        } catch (e) {
          await clearToken();
          token = null;
        }
      }
      if (token == null || token.isEmpty) {
        var result = await getTokenAsAnonymous();
        token = result?.token;
        await storage.write(key: TOKEN_KEY, value: token);
      }
      var userId = await storage.read(key: USER_KEY);
      return TokenInfo(token: token, userId: userId);
    } catch (e) {
      return TokenInfo();
    }
  }

  reloadToken() async {
    await storage.delete(key: TOKEN_KEY);
    await checkSession();
  }

  clearToken() async {
    await storage.delete(key: TOKEN_KEY);
  }

  Future<String?> getTokenFromStorage() async {
    var token = await storage.read(key: TOKEN_KEY);
    return token;
  }

  clearSession() async {
    await storage.deleteAll();
  }

  Future checkSession() async {
    var info = await getToken();
    if (info.token == null || info.token!.trim().isEmpty) {
      await Dialogs.alert(message: "You are in offline mode!");
    }
    Get.offNamedUntil(HomePage.route, (route) => false);
  }

  static int tryTimes = 0;
  Future<TokenInfo> forceGetToken() async {
    tryTimes++;
    TokenInfo? info;
    if (tryTimes < 10) {
      var info = await getToken();
      if (info.token == null || info.token!.trim().isEmpty) {
        info = await forceGetToken();
      }
    }
    tryTimes = 0;
    return info ?? TokenInfo();
  }

  hashSha256(String text) {
    var bytes = utf8.encode(text);
    var digest = sha256.convert(bytes);
    var hex = digest.toString();
    return hex;
  }

  hashMd5(String text) {
    var bytes = utf8.encode(text);
    var digest = md5.convert(bytes);
    var hex = digest.toString();
    return hex;
  }

  computeSig(int ver, String privateKey, ts, data) {
    String _input = "$privateKey$ts${data.join('')}";
    if (ver == 1) {
      return hashSha256(_input);
    } else {
      return hashMd5(_input);
    }
  }

  String buildSig(List<String> data) {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (serverTimestamp != null) {
      now = serverTimestamp ?? 0;
    }
    var _sig = computeSig(1, AppSources.privateKey, now, data);
    return "1:$now:$_sig";
  }
}
