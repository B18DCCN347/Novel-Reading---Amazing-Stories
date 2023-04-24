import 'package:hive/hive.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/data/models/caches/app_cache.dart';
import 'package:love_novel/data/models/caches/chapter_data.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/models/public/book_marker.dart';
import 'package:love_novel/data/models/public/download_package.dart';
import 'package:love_novel/data/models/public/episode.dart';
import 'package:love_novel/data/models/public/package_episode.dart';
import 'package:love_novel/data/models/public/stat.dart';
import 'package:love_novel/data/models/public/viewer_setting.dart';
import 'package:love_novel/data/models/request/action_status.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveTypes {
  static const viewerSetting = 1;
  static const bookMarker = 2;
  static const appCache = 3;
  static const chapterData = 4;
  static const book = 5;
  static const chapter = 6;
  static const category = 7;
  static const actionStatus = 8;
  static const stat = 9;
  static const downloadPackage = 10;
  static const packageEpisode = 11;
}

class HiveBoxes {
  static get viewerSetting => "viewerSetting";
  static get bookMarker => "bookMarker";
  static get appCache => "appCache";
  static get chapterData => "chapterData";
  static get book => "book";
  static get chapter => "chapter";
  static get category => "category";
  static get actionStatus => "actionStatus";
  static get stat => "stat";
  static get downloadPackage => "downloadPackage";
  static get packageEpisode => "packageEpisode";
  static var initialized = false;
  static Future init() async {
    if (!initialized) {
      var path = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(path.path);
      if (!Hive.isAdapterRegistered(HiveTypes.viewerSetting)) {
        Hive.registerAdapter(ViewerSettingAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.bookMarker)) {
        Hive.registerAdapter(BookMarkerAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.appCache)) {
        Hive.registerAdapter(AppCacheAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.chapterData)) {
        Hive.registerAdapter(ChapterDataAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.book)) {
        Hive.registerAdapter(BookAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.chapter)) {
        Hive.registerAdapter(EpisodeAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.category)) {
        Hive.registerAdapter(CategoryAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.actionStatus)) {
        Hive.registerAdapter(ActionStatusAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.stat)) {
        Hive.registerAdapter(StatAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.downloadPackage)) {
        Hive.registerAdapter(DownloadPackageAdapter());
      }
      if (!Hive.isAdapterRegistered(HiveTypes.packageEpisode)) {
        Hive.registerAdapter(PackageEpisodeAdapter());
      }
      HiveBoxController.instance;
      initialized = true;
    }
  }
}
