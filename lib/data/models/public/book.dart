import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/episode.dart';
import 'package:love_novel/data/models/public/stat.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.book)
class Book extends HiveObject {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  int? type;
  @HiveField(2)
  String? lang;
  @HiveField(3)
  int? mainCategory;
  @HiveField(4)
  int? sub1Category;
  @HiveField(5)
  int? sub2Category;
  @HiveField(6)
  int? sub3Category;
  @HiveField(7)
  List<int>? category;
  @HiveField(8)
  List<Category>? categories;
  @HiveField(9)
  String? title;
  @HiveField(10)
  String? author;
  @HiveField(11)
  String? description;
  @HiveField(12)
  String? portraitThumb;
  @HiveField(13)
  String? featureImage;
  @HiveField(14)
  int? isEnded;
  @HiveField(15)
  String? createdDate;
  @HiveField(16)
  String? lastUpdate;
  @HiveField(17)
  int? active;
  @HiveField(18)
  int? totalEpisodes;
  @HiveField(19)
  List<Episode>? episodes;
  @HiveField(20)
  Stat? stats;
  @HiveField(21)
  int? promotion;
  @HiveField(22)
  bool? cached;
  @HiveField(23)
  bool? read;
  @HiveField(24)
  bool? liked;
  @HiveField(25)
  bool? downloaded;
  @HiveField(26)
  bool? completed;
  @HiveField(27)
  bool? hot;
  @HiveField(28)
  bool? newUpdated;
  @HiveField(29)
  bool? discovery;
  @HiveField(30)
  int? order;

  Book(
      {this.uuid,
      this.type,
      this.lang,
      this.mainCategory,
      this.sub1Category,
      this.sub2Category,
      this.sub3Category,
      this.category,
      this.categories,
      this.title,
      this.author,
      this.description,
      this.portraitThumb,
      this.featureImage,
      this.isEnded,
      this.createdDate,
      this.lastUpdate,
      this.active,
      this.totalEpisodes,
      this.episodes,
      this.stats,
      this.promotion,
      this.cached,
      this.read,
      this.liked,
      this.downloaded,
      this.discovery,
      this.hot,
      this.newUpdated,
      this.completed,
      this.order});
  Book clone() {
    return Book(
      uuid: this.uuid,
      type: this.type,
      lang: this.lang,
      mainCategory: this.mainCategory,
      sub1Category: this.sub1Category,
      sub2Category: this.sub2Category,
      sub3Category: this.sub3Category,
      category: this.category,
      categories: this.categories,
      title: this.title,
      author: this.author,
      description: this.description,
      portraitThumb: this.portraitThumb,
      featureImage: this.featureImage,
      isEnded: this.isEnded,
      createdDate: this.createdDate,
      lastUpdate: this.lastUpdate,
      active: this.active,
      totalEpisodes: this.totalEpisodes,
      episodes: this.episodes,
      stats: this.stats,
      promotion: this.promotion,
      cached: this.cached,
      read: this.read,
      liked: this.liked,
      downloaded: this.downloaded,
      order: this.order,
    );
  }

  bindCategory(List<Category> cats) {
    categories = cats.where((e) => (category ?? []).contains(e.id)).toList();
  }

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class BookResponse extends ResultInfo {
  Book? data;

  BookResponse({this.data});

  factory BookResponse.fromJson(Map<String, dynamic> json) =>
      _$BookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookResponseToJson(this);
}

@JsonSerializable()
class BookListResponse extends ResultInfo {
  List<Book>? data;

  BookListResponse({this.data});

  factory BookListResponse.fromJson(Map<String, dynamic> json) =>
      _$BookListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookListResponseToJson(this);
}
