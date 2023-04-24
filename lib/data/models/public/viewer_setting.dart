import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
part 'viewer_setting.g.dart';

@HiveType(typeId: HiveTypes.viewerSetting)
class ViewerSetting extends HiveObject {
  @HiveField(0)
  String font;
  @HiveField(1)
  double size;
  @HiveField(2)
  String theme;
  @HiveField(3)
  int currentPage;

  ViewerSetting({
    required this.font,
    required this.size,
    required this.currentPage,
    required this.theme,
  });
}
