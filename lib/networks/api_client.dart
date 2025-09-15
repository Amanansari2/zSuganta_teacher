import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/configs/routes.dart';
import 'package:z_tutor_suganta/configs/url.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/user_sessions.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          LoggerHelper.debug(
            "➡️ REQUEST [${options.method}] ${options.baseUrl}${options.path} "
                "Headers: ${options.headers} "
                "Data: ${options.data} "
                "Query: ${options.queryParameters}",
          );
          return handler.next(options);
        },
        onResponse: (response, handler) async  {
          LoggerHelper.info(
            "✅ RESPONSE [${response.statusCode}] ${response.requestOptions.uri} "
                "Data: ${response.data}",
          );
          return handler.next(response);
        },
        onError: (e, handler) async {
          LoggerHelper.error(
            "❌ ERROR [${e.response?.statusCode}] ${e.requestOptions.uri}\n"
                "Response: ${e.response?.data}",
            e.error,
          );


          if (e.response?.statusCode == 401) {
           // await LocalStorageService.clearAuthDataRedirect();
           final context = AppRouter.rootNavigatorKey.currentContext;
           if (context != null) {
             context.read<UserSessionProvider>().logout();
           }
            return handler.next(e);
          }


          if (_shouldRetry(e)) {
            LoggerHelper.warning("⚠️ Retrying request: ${e.requestOptions.uri}");
            try {
              await Future.delayed(const Duration(seconds: 2));
              final retryCount = e.requestOptions.extra["retry_count"] ?? 0;
              e.requestOptions.extra["retry_count"] = retryCount + 1;

              final response = await _dio.fetch(e.requestOptions);
              return handler.resolve(response);
            } catch (err) {
              return handler.next(err as DioError);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  bool _shouldRetry(DioError e) {
    const maxRetries = 3;
    final retryCount = e.requestOptions.extra["retry_count"] ?? 0;

    final retryable = e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.sendTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.unknown;

    return retryable && retryCount < maxRetries;
  }

  void dispose() {
    _dio.close(force: true);
  }
}
