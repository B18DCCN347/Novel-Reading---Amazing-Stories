import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/app_config.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/models/public/book_collection.dart';
import 'package:love_novel/data/models/public/download_package.dart';
import 'package:love_novel/data/models/request/chapters_response.dart';
import 'package:love_novel/data/models/request/collection_response.dart';
import 'package:love_novel/data/models/request/episode_link_response.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'book.g.dart';

@RestApi()
abstract class BookApi {
  factory BookApi(Dio dio) = _BookApi;
  @GET('/app/home?api-key={apiKey}&lang={langCode}')
  Future<BookCollectionListResponse?> homeInfo(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Header("X-Req-Sig") String sign, //<sig(token, uuid, lang)>
  );
  @GET('/app/config?api-key={apiKey}&lang={langCode}')
  Future<AppConfig?> configInfo(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Header("X-Req-Sig") String sign, // <sig(token, uuid)>
  );
  @GET('/app/category?api-key={apiKey}&lang={langCode}')
  Future<CategoryListResponse?> categories(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Header("X-Req-Sig") String sign, // <sig(token, uuid)>
  );
  @GET(
      '/app/collection/{codeName}?api-key={apiKey}&lang={langCode}&offset={offset}&count={count}')
  Future<CollectionResponse?> books(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("codeName") String codeName,
    @Path("offset") int offset,
    @Path("count") int count,
    @Header("X-Req-Sig")
        String sign, // <sig(token, uuid, codename, offset, count)>
  );

  @GET('/app/content/{bookId}?api-key={apiKey}&lang={langCode}')
  Future<BookResponse?> bookDetail(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Header("X-Req-Sig") String sign, // <sig(token, uuid, bookId)>
  );

  @POST(
      '/app/content/mark-read/{bookId}/ep/{chapterId}?api-key={apiKey}&lang={langCode}')
  Future<ResultInfo?> markRead(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Path("chapterId") String chapterId,
    @Header("X-Req-Sig") String sign,
  );

  @GET(
      '/app/content-episodes/{bookId}?api-key={apiKey}&lang={langCode}&offset={offset}&count={count}')
  Future<ChaptersResponse?> episodes(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Path("offset") int offset,
    @Path("count") int count,
    @Header("X-Req-Sig")
        String sign, // <sig(token, uuid, bookId, offset, count)>
  );

  @GET('/app/content/{bookId}/ep/{episodeId}?api-key={apiKey}&lang={langCode}')
  Future<EpisodeLinkResponse?> episodeLink(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Path("episodeId") String episodeId,
    @Header("X-Req-Sig") String sign, // <sig(token, uuid, bookId, episodeId)>
  );

  @GET('/app/search?api-key={apiKey}&lang={langCode}&q={keyword}')
  Future<BookListResponse?> search(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("keyword") String keyword,
    @Header("X-Req-Sig") String sign, // <sig(token, uuid, keyword)>
  );

  @GET('/app/content-package/meta/{bookId}?api-key={apiKey}&lang={langCode}')
  Future<DownloadPackageListResponse?> fetchDownloadPackages(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Header("X-Req-Sig") String sign,
  );
  @GET('/app/content-package/download/{packageId}?hash={hash}&api-key={apiKey}')
  Future<DownloadPackageResponse?> downloadPackage(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("packageId") String packageId,
    @Path("hash") String hash,
    @Header("X-Req-Sig") String sign,
  );
}
