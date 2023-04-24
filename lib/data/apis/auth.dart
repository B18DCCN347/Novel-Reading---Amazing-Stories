import 'dart:async';
import 'package:dio/dio.dart';
import 'package:love_novel/data/models/request/auth_result.dart';
import 'package:love_novel/data/models/request/validate_token_result.dart';
import 'package:retrofit/http.dart';

part 'auth.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;
  @POST("/customer/auth/register-anonymous?api-key={apiKey}")
  Future<AuthResult?> registerAnonymous(
    @Path("apiKey") String apiKey,
  );
  @POST("/customer/auth/login-as-anonymous?api-key={apiKey}")
  Future<AuthResult?> token(
    @Path("apiKey") String apiKey,
    @Field("uuid") String uuid,
  );
  @GET("/customer/auth/token?api-key={apiKey}")
  Future<ValidateTokenResult?> validateToken(
    @Header("X-TOKEN") String token,
    @Path("apiKey") String apiKey,
    @Header("X-Req-Sig") String sign,
  );
}
