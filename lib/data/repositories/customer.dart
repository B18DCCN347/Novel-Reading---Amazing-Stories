import 'package:flutter/material.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/sources.dart';
import 'package:love_novel/data/apis/base.dart';
import 'package:love_novel/data/apis/customer.dart';
import 'package:love_novel/data/models/public/feature.dart';
import 'package:love_novel/data/models/request/action_status.dart';
import 'package:love_novel/data/models/request/collection_response.dart';
import 'package:love_novel/data/models/request/purchase_result.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:love_novel/data/repositories/auth.dart';

class CustomerRepository {
  CustomerApi api = API.getCustomerApi();

  Future<CollectionResponse?> recentReadBooks(int offset, int count) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      offset.toString(),
      count.toString(),
    ]);
    var response = await api
        .recentReadBooks(info.token!, AppSources.apiKey, lang, offset, count, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<ResultInfo?> removeHistory(String bookId) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository()
        .buildSig([info.token ?? "", info.userId ?? "", bookId]);
    var response = await api
        .removeHistory(info.token!, AppSources.apiKey, lang, bookId, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<ResultInfo?> like(String bookId) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository()
        .buildSig([info.token ?? "", info.userId ?? "", bookId]);
    var response = await api
        .like(info.token!, AppSources.apiKey, lang, bookId, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<ResultInfo?> unlike(String bookId) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository()
        .buildSig([info.token ?? "", info.userId ?? "", bookId]);
    var response = await api
        .unlike(info.token!, AppSources.apiKey, lang, bookId, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<CollectionResponse?> likedBooks(int offset, int count) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      offset.toString(),
      count.toString(),
    ]);
    var response = await api
        .likedBooks(info.token!, AppSources.apiKey, lang, offset, count, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<ResultInfo?> rate(String bookId, int score) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig(
        [info.token ?? "", info.userId ?? "", bookId, score.toString()]);
    var response = await api
        .rate(info.token!, AppSources.apiKey, lang, bookId, score, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<CollectionResponse?> ratedBooks(int offset, int count) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      offset.toString(),
      count.toString(),
    ]);
    var response = await api
        .ratedBooks(info.token!, AppSources.apiKey, lang, offset, count, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<ActionStatus?> actionStatus(String bookId) async {
    var info = await AuthRepository().getToken().catchError((error) {});
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      bookId,
    ]);
    var response = await api
        .actionStatus(info.token!, AppSources.apiKey, lang, bookId, sig)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response;
    return null;
  }

  Future<PurchaseResult?> buyFeature(String iapPackage, String receipt) async {
    var info = await AuthRepository().getToken().catchError((error) {});
    var sig = AuthRepository()
        .buildSig([info.token ?? "", info.userId ?? "", iapPackage, receipt]);
    var response = await api
        .buyFeature(info.token!, AppSources.apiKey, iapPackage, receipt, sig)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response;
    return null;
  }

  Future<FeatureListResponse?> fetchFeatures() async {
    if(!AppController.hasConnection)
    return null;
    var info = await AuthRepository().getToken().catchError((error) {});
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
    ]);
    var response =
        await api.fetchFeatures(info.token!, AppSources.apiKey, sig).catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response;
    return null;
  }
}
