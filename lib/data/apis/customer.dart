import 'package:love_novel/data/models/public/feature.dart';
import 'package:love_novel/data/models/request/action_status.dart';
import 'package:love_novel/data/models/request/collection_response.dart';
import 'package:love_novel/data/models/request/purchase_result.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'customer.g.dart';

@RestApi()
abstract class CustomerApi {
  factory CustomerApi(Dio dio) = _CustomerApi;
  @GET(
      '/customer/act/recent-read?api-key={apiKey}&lang={langCode}&offset={offset}&count={count}')
  Future<CollectionResponse?> recentReadBooks(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("offset") int offset,
    @Path("count") int count,
    @Header("X-Req-Sig")
        String sign, // <sig(token, uuid, codename, offset, count)>
  );

  @POST('/customer/act/remove-history/{bookId}?api-key={apiKey}&lang={langCode}')
  Future<ResultInfo?> removeHistory(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Header("X-Req-Sig") String sign,
  );

  @POST('/customer/act/like/{bookId}?api-key={apiKey}&lang={langCode}')
  Future<ResultInfo?> like(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Header("X-Req-Sig") String sign, 
  );
  @POST('/customer/act/unlike/{bookId}?api-key={apiKey}&lang={langCode}')
  Future<ResultInfo?> unlike(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Header("X-Req-Sig") String sign, 
  );
  @GET(
      '/customer/act/like-contents?api-key={apiKey}&lang={langCode}&offset={offset}&count={count}')
  Future<CollectionResponse?> likedBooks(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("offset") int offset,
    @Path("count") int count,
    @Header("X-Req-Sig")
        String sign, // <sig(token, uuid, codename, offset, count)>
  );

  @POST('/customer/act/rate/{bookId}?api-key={apiKey}&lang={langCode}')
  Future<ResultInfo?> rate(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Field("score") int score,
    @Header("X-Req-Sig") String sign,
  );

  
  @GET(
      '/customer/act/rated-contents?api-key={apiKey}&lang={langCode}&offset={offset}&count={count}')
  Future<CollectionResponse?> ratedBooks(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("offset") int offset,
    @Path("count") int count,
    @Header("X-Req-Sig")
        String sign, // <sig(token, uuid, codename, offset, count)>
  );
  @GET(
      '/customer/act/content-action-status/{bookId}?api-key={apiKey}&lang={langCode}')
  Future<ActionStatus?> actionStatus(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Path("langCode") String langCode,
    @Path("bookId") String bookId,
    @Header("X-Req-Sig")
        String sign, 
  );

  //In app purchases
  
  @POST('/customer/feature/submit?api-key={apiKey}')
  Future<PurchaseResult?> buyFeature(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Field("iapPackage") String iapPackage,
    @Field("receipt") String receipt,
    @Header("X-Req-Sig") String sign,
  );

  
  @GET('/customer/feature/fetch?api-key={apiKey}')
  Future<FeatureListResponse?> fetchFeatures(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Header("X-Req-Sig")
        String sign, 
  );
  
}
