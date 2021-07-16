import 'package:dio/dio.dart';
import 'package:netflix/base/log.dart';

class APILogInterceptor extends InterceptorsWrapper {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logDebug('');
    logDebug('# ERROR');
    logDebug('<-- ${err.response?.statusCode} - ${err.requestOptions.uri}');
    logDebug('Message: ${err.error}');
    logDebug('<-- END HTTP');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logDebug('');
    logDebug('# REQUEST');
    final method = options.method.toUpperCase();
    logDebug('--> $method - ${options.uri}');
    logDebug('Headers: ${options.headers}');
    logDebug('Data: ${options.data}');
    logDebug('--> END $method');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logDebug('');
    logDebug('# RESPONSE');
    logDebug('<-- ${response.statusCode} - ${response.requestOptions.uri}');
    logDebug('Response: ${response.data}');
    logDebug('<-- END HTTP');
    return super.onResponse(response, handler);
  }
}