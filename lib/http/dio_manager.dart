
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/print_utils.dart';

String baseUrl = "";
ResponseType responseType = ResponseType.json;
int receiveTimeout = 60;
int sendTimeout = 60;
int connectTimeout = 60;

class DioManager {

  static DioManager? _instance;

  static Dio? _dio;

  BaseOptions? options;

  static DioManager getInstant() {
    _instance ??= DioManager();
    return _instance!;
  }

  DioManager() {
    options = BaseOptions(
      baseUrl: baseUrl,
      responseType: responseType,
      receiveTimeout: Duration(seconds: receiveTimeout),
      sendTimeout: Duration(seconds: sendTimeout),
      connectTimeout: Duration(seconds: connectTimeout),
    );
    _dio = Dio(options);
    _dio?.interceptors.add(PrintInterceptor());
  }

  /// 添加拦截器
  void addInterceptor(Interceptor interceptor) {
    _dio?.interceptors.add(interceptor);
  }

  /// 移除拦截器
  void removeInterceptor(Interceptor interceptor) {
    _dio?.interceptors.remove(interceptor);
  }

  /// get 方式
  Future<dynamic> get({
    required String path,
    Options? options,
    dynamic queryParameters,
    dynamic data,
  }) async {
    Response response;
    try {
      response = await _dio!.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (dioError) {
      return dioError.response;
    } on Error catch (error) {
      return error;
    }
  }

  /// post 请求，上传文件
  ///
  /// single 添加到 data 中
  /// MultipartFile multipartFile =await MultipartFile.fromFile("filePath");
  ///
  /// Multiple 添加到 data 中
  /// List<MultipartFile> fs = [await MultipartFile.fromFile("filePath")];
  ///
  Future<dynamic> post({
    required String path,
    Options? options,
    dynamic data,
    Function(int)? progress,
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress,
  }) async {
    try {
      Response response = await _dio!.post(
        path,
        data: data,
        options: options,
        onSendProgress: (count, total) => onSendProgress,
        onReceiveProgress: (count, total) => onReceiveProgress,
      );
      return response;
    } on DioException catch (dioError) {
      return dioError.response;
    } on Error catch (error) {
      return error;
    }
  }

  /// post 请求，上传文件
  ///
  /// single 添加到 data 中
  /// MultipartFile multipartFile =await MultipartFile.fromFile("filePath");
  ///
  /// Multiple 添加到 data 中
  /// List<MultipartFile> fs = [await MultipartFile.fromFile("filePath")];
  ///
  Future<dynamic> postFile({
    required String path,
    Options? options,
    dynamic data,
    Function(int)? progress,
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response response = await _dio!.post(
        path,
        data: formData,
        options: options,
        onSendProgress: (count, total) => onSendProgress,
        onReceiveProgress: (count, total) => onReceiveProgress,
      );
      return response;
    } on DioException catch (dioError) {
      return dioError.response;
    } on Error catch (error) {
      return error;
    }
  }

  /// 清除
  void clear() {
    _dio = null;
  }
}

class PrintInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      printRed('''
      打印拦截器 请求地址：${options.uri} \n 方法：${options.method} \n 头部：${options.headers} \n 参数：${options.data}
      ''');
    }
    return handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      printRed('''
      打印拦截器 响应数据：状态Code：${response.statusCode}  状态数据：${response.statusMessage} \n 头部 ${response.headers} \n 数据：${response.data}
      ''');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      printRed('''
      打印拦截器 异常数据：$err
      ''');
    }
    return handler.next(err);
  }
}
