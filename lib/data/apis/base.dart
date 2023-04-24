import 'package:dio/dio.dart';
import 'package:love_novel/app/global/sources.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/apis/auth.dart';
import 'package:love_novel/data/apis/book.dart';
import 'package:love_novel/data/apis/customer.dart';
import 'package:love_novel/data/repositories/auth.dart';
import 'package:love_novel/app/global/controller.dart';

class API {
  static final _apiDio = Dio();
  static final _controller = AppController.instance;
  static init({bool logEnabled = false}) async {
    _initApiDio(logEnabled: logEnabled);
  }

  static _initApiDio({bool logEnabled = false}) {
    _apiDio.options.baseUrl = "${AppSources.apiUrl}/";
    _apiDio.options.receiveDataWhenStatusError = true;
    _apiDio.options.connectTimeout = 60 * 1000;
    _apiDio.options.receiveTimeout = 60 * 1000;
    if (logEnabled)
      _apiDio.interceptors.add(LogInterceptor(responseBody: true));
    _apiDio.interceptors.add(
      InterceptorsWrapper(onRequest: (RequestOptions requestOptions,
          RequestInterceptorHandler handler) async {
        // String token = "";
        // try {
        //   token = (await AuthRepository().getTokenFromStorage()) ?? "";
        // } catch (e) {}
        // requestOptions.headers.putIfAbsent("X-TOKEN", () => token);

        handler.next(requestOptions);
        //
        //
        // return requestOptions;
        if (!AppController.hasConnection) return;
      }, onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (error.type == DioErrorType.response) {
          if (error.response?.statusCode == 401) {
          } else if (error.response?.statusCode == 499) {
          } else if (error.response?.statusCode == 403) {
            try {
              AuthRepository.serverTimestamp = error.response?.data["sTime"];
            } catch (e) {}
          } else {
            // Dialogs.alert(message:"Error: "+ error.message);
          }
        }
        return handler.next(error);
      }),
    );
  }

  static AuthApi? _AuthApi;
  static AuthApi getAuthApi() => _AuthApi ?? (_AuthApi = AuthApi(_apiDio));

  static BookApi? _BookApi;
  static BookApi getBookApi() => _BookApi ?? (_BookApi = BookApi(_apiDio));

  static CustomerApi? _CustomerApi;
  static CustomerApi getCustomerApi() =>
      _CustomerApi ?? (_CustomerApi = CustomerApi(_apiDio));
}
