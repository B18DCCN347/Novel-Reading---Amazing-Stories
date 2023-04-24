// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _BookApi implements BookApi {
  _BookApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BookCollectionListResponse?> homeInfo(
      token, apiKey, langCode, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<BookCollectionListResponse>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/app/home?api-key=${apiKey}&lang=${langCode}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : BookCollectionListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AppConfig?> configInfo(token, apiKey, langCode, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<AppConfig>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/app/config?api-key=${apiKey}&lang=${langCode}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : AppConfig.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CategoryListResponse?> categories(
      token, apiKey, langCode, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<CategoryListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/app/category?api-key=${apiKey}&lang=${langCode}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : CategoryListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CollectionResponse?> books(
      token, apiKey, langCode, codeName, offset, count, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        CollectionResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/app/collection/${codeName}?api-key=${apiKey}&lang=${langCode}&offset=${offset}&count=${count}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : CollectionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookResponse?> bookDetail(
      token, apiKey, langCode, bookId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<BookResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/app/content/${bookId}?api-key=${apiKey}&lang=${langCode}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : BookResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResultInfo?> markRead(
      token, apiKey, langCode, bookId, chapterId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        ResultInfo>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/app/content/mark-read/${bookId}/ep/${chapterId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : ResultInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChaptersResponse?> episodes(
      token, apiKey, langCode, bookId, offset, count, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        ChaptersResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/app/content-episodes/${bookId}?api-key=${apiKey}&lang=${langCode}&offset=${offset}&count=${count}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : ChaptersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EpisodeLinkResponse?> episodeLink(
      token, apiKey, langCode, bookId, episodeId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        EpisodeLinkResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/app/content/${bookId}/ep/${episodeId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : EpisodeLinkResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookListResponse?> search(
      token, apiKey, langCode, keyword, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<BookListResponse>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/app/search?api-key=${apiKey}&lang=${langCode}&q=${keyword}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : BookListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DownloadPackageListResponse?> fetchDownloadPackages(
      token, apiKey, langCode, bookId, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        DownloadPackageListResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/app/content-package/meta/${bookId}?api-key=${apiKey}&lang=${langCode}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DownloadPackageListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DownloadPackageResponse?> downloadPackage(
      token, apiKey, packageId, hash, sign) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-TOKEN': token, r'X-Req-Sig': sign};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(_setStreamType<
        DownloadPackageResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/app/content-package/download/${packageId}?hash=${hash}&api-key=${apiKey}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : DownloadPackageResponse.fromJson(_result.data!);
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
