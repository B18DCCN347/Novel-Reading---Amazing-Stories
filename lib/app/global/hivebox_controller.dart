import 'package:connectivity/connectivity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/app/utils/string_helper.dart';
import 'package:love_novel/data/models/caches/app_cache.dart';
import 'package:love_novel/data/models/caches/chapter_data.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/models/public/book_marker.dart';
import 'package:love_novel/data/models/public/download_package.dart';
import 'package:love_novel/data/models/public/episode.dart';
import 'package:love_novel/data/models/public/fullscreen_ads_cap.dart';
import 'package:love_novel/data/models/public/package_episode.dart';
import 'package:love_novel/data/models/public/viewer_setting.dart';
import 'package:love_novel/data/models/request/action_status.dart';
import 'package:love_novel/data/repositories/hive_box.dart';

class HiveBoxController extends GetxController {
  static HiveBoxController get instance => Get.isRegistered<HiveBoxController>()
      ? Get.find()
      : Get.put(HiveBoxController());
  static var connectivityResult = Rxn<ConnectivityResult>();

  late HiveBoxRepository<ChapterData> chapterDataBoxRepository;
  late HiveBoxRepository<ViewerSetting> viewerSettingBoxRepository;
  late HiveBoxRepository<BookMarker> bookMarkerBoxRepository;
  late HiveBoxRepository<AppCache> appCacheBoxRepository;
  late HiveBoxRepository<Book> bookBoxRepository;
  late HiveBoxRepository<Episode> chapterBoxRepository;
  late HiveBoxRepository<Category> categoryBoxRepository;
  late HiveBoxRepository<ActionStatus> actionStatusBoxRepository;
  late HiveBoxRepository<DownloadPackage> downloadPackageBoxRepository;
  late HiveBoxRepository<PackageEpisode> packageEpisodeBoxRepository;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() async {
    chapterDataBoxRepository =
        HiveBoxRepository<ChapterData>(HiveBoxes.chapterData);
    viewerSettingBoxRepository =
        HiveBoxRepository<ViewerSetting>(HiveBoxes.viewerSetting);
    bookMarkerBoxRepository =
        HiveBoxRepository<BookMarker>(HiveBoxes.bookMarker);
    appCacheBoxRepository = HiveBoxRepository<AppCache>(HiveBoxes.appCache);
    bookBoxRepository = HiveBoxRepository<Book>(HiveBoxes.book);
    chapterBoxRepository = HiveBoxRepository<Episode>(HiveBoxes.chapter);
    categoryBoxRepository = HiveBoxRepository<Category>(HiveBoxes.category);
    actionStatusBoxRepository =
        HiveBoxRepository<ActionStatus>(HiveBoxes.actionStatus);
    downloadPackageBoxRepository =
        HiveBoxRepository<DownloadPackage>(HiveBoxes.downloadPackage);
    packageEpisodeBoxRepository =
        HiveBoxRepository<PackageEpisode>(HiveBoxes.packageEpisode);
  }

  final storage = FlutterSecureStorage();
  static const _appRatingKey = "___appRated__";
  static const _firstTimestampKey = "___firstTimestamp__";
  static var firstTimestamp = 0;
  static var needToShowAppRating = false;
  final InAppReview inAppReview = InAppReview.instance;
  static var isPriority = true;
  static var adConfig = FullscreenAdsCap(
      minChapter: 2, minAdGapInSec: 420, videoInterstitialAlternative: true);
  static var chapterCounter = 0;
  static var videoShown = false;
  static var timeMarker = DateTime.now().millisecondsSinceEpoch;

  updateDownloadPackages(List<DownloadPackage> downloadPackages) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in downloadPackages) {
          await saveOrUpdateDownloadPackage(element, downloaded: true);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  Future<DownloadPackage?> getDownloadPackage(String downloadPackageId) async {
    var items = downloadPackageBoxRepository.getAll();
    var existItem =
        items.firstWhereOrNull((element) => downloadPackageId == element.id);
    return existItem;
  }

  saveOrUpdateDownloadPackage(
    DownloadPackage data, {
    bool? downloaded,
  }) async {
    try {
      var existItem = await getDownloadPackage(data.id ?? "");
      var cloneElement = data.clone();
      cloneElement.downloaded = existItem?.downloaded ?? false;
      if (downloaded != null) cloneElement.downloaded = downloaded;
      if (existItem != null) {
        await downloadPackageBoxRepository.update(existItem.key, cloneElement);
      } else {
        await downloadPackageBoxRepository.add(cloneElement);
      }
    } catch (e) {}
  }

  cleanAndUpdateBooks(List<Book> books) async {
    try {
      var newIds = books.map((e) => e.uuid);
      var notValidKeys = (await bookBoxRepository.safeGetAll())
          .where((element) => !newIds.contains(element.uuid))
          .toList();
      await bookBoxRepository.deleteAll(notValidKeys);
      await updateBooks(books);
    } catch (e) {}
  }

  saveOrUpdateBook(
    Book data, {
    bool? read,
    bool? liked,
    bool? downloaded,
    bool? discovery,
    bool? hot,
    bool? lastestRelease,
    bool? completed,
  }) async {
    try {
      var existItem = await getBook(data.uuid ?? "");
      var cloneElement = data.clone();
      cloneElement.cached = true;
      cloneElement.read = existItem?.read ?? false;
      cloneElement.downloaded = existItem?.downloaded ?? false;
      cloneElement.liked = existItem?.liked ?? false;
      cloneElement.discovery = existItem?.discovery ?? false;
      cloneElement.hot = existItem?.hot ?? false;
      cloneElement.newUpdated = existItem?.newUpdated ?? false;
      cloneElement.completed = existItem?.completed ?? false;
      if (read != null) cloneElement.read = read;
      if (liked != null) cloneElement.liked = liked;
      if (downloaded != null) cloneElement.downloaded = downloaded;
      if (discovery != null) cloneElement.discovery = discovery;
      if (hot != null) cloneElement.hot = hot;
      if (lastestRelease != null) cloneElement.newUpdated = lastestRelease;
      if (completed != null) cloneElement.completed = completed;

      cloneElement.portraitThumb = await StringHelper.networkImageToBase64(
          cloneElement.portraitThumb ?? "");
      if (existItem != null) {
        await bookBoxRepository.update(existItem.key, cloneElement);
      } else {
        await bookBoxRepository.add(cloneElement);
      }
    } catch (e) {}
  }

  static var _updating = false;

  updateBooks(List<Book> books) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in books) {
          await saveOrUpdateBook(element);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  updateReadBooks(List<Book> books) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in books) {
          await saveOrUpdateBook(element, read: true);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  updateLikedBooks(List<Book> books) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in books) {
          await saveOrUpdateBook(element, liked: true);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  updateDownloadedBooks(List<Book> books) async {
    if (!_updating) {
      _updating = true;
      for (var element in books) {
        await saveOrUpdateBook(element, downloaded: true);
      }
      _updating = false;
    }
  }

  updateHotBooks(List<Book> books) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in books) {
          await saveOrUpdateBook(element, hot: true);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  updateDiscoveryBooks(List<Book> books) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in books) {
          await saveOrUpdateBook(element, discovery: true);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  updateCompletedBooks(List<Book> books) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in books) {
          await saveOrUpdateBook(element, completed: true);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  updateLastReleasedBooks(List<Book> books) async {
    try {
      if (!_updating) {
        _updating = true;
        for (var element in books) {
          await saveOrUpdateBook(element, lastestRelease: true);
        }
        _updating = false;
      }
    } catch (e) {}
  }

  Future<Book?> getBook(String bookId) async {
    var items = bookBoxRepository.getAll();
    var existItem = items.firstWhereOrNull((element) => bookId == element.uuid);
    return existItem;
  }

  saveOrUpdateChapterData(ChapterData data) async {
    try {
      var existItem = await getChapterData(data.bookId, data.chapterId);
      if (existItem != null) {
        chapterDataBoxRepository.update(existItem.key, data);
      } else {
        chapterDataBoxRepository.add(data);
      }
    } catch (e) {}
  }

  Future<ChapterData?> getChapterData(String bookId, String chapterId) async {
    var items = await chapterDataBoxRepository.safeGetAll();
    var existItem = items.firstWhereOrNull((element) =>
        bookId == element.bookId && chapterId == element.chapterId);
    return existItem;
  }

  saveOrUpdateActionStatus(ActionStatus data) async {
    try {
      var existItem = await getActionStatus(data.bookId ?? "");
      if (existItem != null) {
        actionStatusBoxRepository.update(existItem.key, data);
      } else {
        actionStatusBoxRepository.add(data);
      }
    } catch (e) {}
  }

  Future<ActionStatus?> getActionStatus(String bookId) async {
    var items = await actionStatusBoxRepository.safeGetAll();
    var existItem =
        items.firstWhereOrNull((element) => bookId == element.bookId);
    return existItem;
  }

  // theme setting
  saveOrUpdateActionSetting(ViewerSetting data) async {
    try {
      viewerSettingBoxRepository.add(data);
    } catch (e) {}
  }
}
