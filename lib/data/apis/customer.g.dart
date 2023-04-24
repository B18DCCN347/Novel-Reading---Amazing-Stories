// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _CustomerApi implements CustomerApi {
  _CustomerApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CollectionResponse?> recentReadBooks(
      token, apiKey, langCode, offset, count, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        CollectionResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/recent-read?api-key=${apiKey}&lang=${langCode}&offset=${offset}&count=${count}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : CollectionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResultInfo?> removeHistory(
      token, apiKey, langCode, bookId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        ResultInfo>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/remove-history/${bookId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : ResultInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResultInfo?> like(token, apiKey, langCode, bookId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        ResultInfo>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/like/${bookId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : ResultInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResultInfo?> unlike(token, apiKey, langCode, bookId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        ResultInfo>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/unlike/${bookId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : ResultInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CollectionResponse?> likedBooks(
      token, apiKey, langCode, offset, count, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        CollectionResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/like-contents?api-key=${apiKey}&lang=${langCode}&offset=${offset}&count=${count}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : CollectionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResultInfo?> rate(token, apiKey, langCode, bookId, score, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'score': score};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        ResultInfo>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/rate/${bookId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : ResultInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CollectionResponse?> ratedBooks(
      token, apiKey, langCode, offset, count, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        CollectionResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/rated-contents?api-key=${apiKey}&lang=${langCode}&offset=${offset}&count=${count}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : CollectionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ActionStatus?> actionStatus(
      token, apiKey, langCode, bookId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        ActionStatus>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/customer/act/content-action-status/${bookId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : ActionStatus.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PurchaseResult?> buyFeature(
      token, apiKey, iapPackage, receipt, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'iapPackage': iapPackage, 'receipt': receipt};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<PurchaseResult>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/customer/feature/submit?api-key=${apiKey}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : PurchaseResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FeatureListResponse?> fetchFeatures(token, apiKey, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<FeatureListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/customer/feature/fetch?api-key=${apiKey}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : FeatureListResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
