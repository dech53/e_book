import 'package:dio/dio.dart';
import 'package:e_book/http/http_methods.dart';
import 'package:e_book/http/print_log_interceptor.dart';
import 'package:e_book/http/response_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;
  DioInstance._();
  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTimeout = const Duration(seconds: 30);
  void initDio({
    String? httpMethod = HttpMethods.get,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
        method: httpMethod,
        connectTimeout: connectionTimeout ?? _defaultTimeout,
        receiveTimeout: receiveTimeout ?? _defaultTimeout,
        sendTimeout: sendTimeout ?? _defaultTimeout,
        responseType: responseType,
        contentType: contentType);
    _dio.interceptors.add(ResponseInterceptor());
    _dio.interceptors.add(PrintLogInterceptor());
  }

  Future<Response> get({
    required String path,
    Object? data,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _dio.get(
      path,
      queryParameters: param,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
            method: HttpMethods.get,
            receiveTimeout: _defaultTimeout,
            sendTimeout: _defaultTimeout,
          ),
    );
  }

  Future<String> getString({
    required String path,
    Object? data,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Response response = await _dio.get(
      path,
      queryParameters: param,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
            method: HttpMethods.get,
            receiveTimeout: _defaultTimeout,
            sendTimeout: _defaultTimeout,
          ),
    );
    return response.data.toString();
  }

  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _dio.post(
      path,
      queryParameters: param,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
            method: HttpMethods.post,
            receiveTimeout: _defaultTimeout,
            sendTimeout: _defaultTimeout,
          ),
    );
  }
}
