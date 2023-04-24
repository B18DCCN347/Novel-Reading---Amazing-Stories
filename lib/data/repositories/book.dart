import 'package:flutter/material.dart';
import 'package:love_novel/app/global/sources.dart';
import 'package:love_novel/data/apis/base.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/app_config.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/models/public/book_collection.dart';
import 'package:love_novel/data/models/public/download_package.dart';
import 'package:love_novel/data/models/request/chapters_response.dart';
import 'package:love_novel/data/models/request/collection_response.dart';
import 'package:love_novel/data/models/request/episode_link_response.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:love_novel/data/repositories/auth.dart';

class BookRepository {
  final api = API.getBookApi();
  static int tryTimes = 0;
  Future<AppConfig?> configInfo() async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([info.token ?? "", info.userId ?? ""]);
    AppConfig? response;
    response = await api
        .configInfo(info.token!, AppSources.apiKey, lang, sig)
        .catchError((error) async {
      debugPrint(error.toString());
      if (error.response?.statusCode == 403) {
        try {
          AuthRepository.serverTimestamp = error.response?.data["sTime"];
        } catch (e) {}
      }
      tryTimes++;
      if (tryTimes < 10) {
        response = await configInfo();
      }
    });
    tryTimes = 0;
    if (response?.success ?? false) return response;
    return null;
  }

  Future<CategoryListResponse?> categories() async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig =
        AuthRepository().buildSig([info.token ?? "", info.userId ?? "", lang]);
    var response =
        await api.categories(info.token!, AppSources.apiKey, lang, sig).catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response;
    return null;
  }

  Future<CollectionResponse?> books(
      String codeName, int offset, int count) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      codeName,
      offset.toString(),
      count.toString(),
    ]);
    var response = await api
        .books(info.token!, AppSources.apiKey, lang, codeName, offset, count, sig)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response;
    return null;
  }

  Future<CollectionResponse?> booksByCatId(
      int catId, int offset, int count) async {
    return books("cat_$catId", offset, count);
  }

  Future<List<BookCollection>?> discovery() async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig =
        AuthRepository().buildSig([info.token ?? "", info.userId ?? "", lang]);
    var response =
        await api.homeInfo(info.token!, AppSources.apiKey, lang, sig).catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response?.data;
    return null;
  }

  Future<CollectionResponse?> hotBooks(int offset, int count) async {
    // return books("__top_read-en", offset, count);
    return books("editor_choice", offset, count);
  }

  Future<CollectionResponse?> booksByCodeName(
      String codeName, int offset, int count) async {
    return books(codeName, offset, count);
  }

  Future<CollectionResponse?> newUpdatedBooks(int offset, int count) async {
    return books("__new_update-en", offset, count);
  }

  Future<CollectionResponse?> completedBooks(int offset, int count) async {
    return books("__full-en", offset, count);
  }

  Future<Book?> bookDetail(String bookId) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      bookId,
    ]);
    var response = await api
        .bookDetail(info.token!, AppSources.apiKey, lang, bookId, sig)
        .catchError((error) {});
    if (response?.data != null) return response!.data;
    return null;
  }

  Future<ResultInfo?> markRead(String bookId, String chapterId) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      bookId,
      chapterId,
    ]);
    var response = await api
        .markRead(info.token!, AppSources.apiKey, lang, bookId, chapterId, sig)
        .catchError((error) {
      debugPrint(error.toString());
    });
    return response;
  }

  Future<ChaptersResponse?> episodes(
      String bookId, int offset, int count) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      bookId,
      offset.toString(),
      count.toString(),
    ]);
    var response = await api
        .episodes(info.token!, AppSources.apiKey, lang, bookId, offset, count, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<EpisodeLinkResponse?> episodeLink(
      String bookId, String episodeId) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      bookId,
      episodeId,
    ]);
    var response = await api
        .episodeLink(info.token!, AppSources.apiKey, lang, bookId, episodeId, sig)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response;
    return null;
  }

  Future<BookListResponse?> search(String keyword) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      keyword,
    ]);
    var response = await api
        .search(info.token!, AppSources.apiKey, lang, keyword, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }

  Future<DownloadPackageListResponse?> fetchDownloadPackages(
      String bookId) async {
    var info = await AuthRepository().getToken();
    if ((info.token ?? "").isEmpty) return null;
    var lang = "en";
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
      bookId,
    ]);
    var response = await api
        .fetchDownloadPackages(info.token!, AppSources.apiKey, lang, bookId, sig)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response?.success ?? false) return response;
    return null;
  }

  Future<DownloadPackageResponse?> downloadPackage(
    String packageId,
    String hash,
  ) async {
    var info = await AuthRepository().getToken();
    var sig = AuthRepository().buildSig([
      info.token ?? "",
      info.userId ?? "",
    ]);
    var response = await api
        .downloadPackage(info.token!, AppSources.apiKey, packageId, hash, sig)
        .catchError((error) {});
    if (response?.success ?? false) return response;
    return null;
  }
}
