import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
part 'book_marker.g.dart';

@HiveType(typeId: HiveTypes.bookMarker)
class BookMarker extends HiveObject {
  @HiveField(0)
  String bookId;
  @HiveField(1)
  String chapterId;
  @HiveField(2)
  double position;

  BookMarker({
    required this.bookId,
    required this.chapterId,
    required this.position,
  });
}
