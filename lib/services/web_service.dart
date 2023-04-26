import 'dart:convert';
import 'dart:developer';
import 'package:ticket_module/const_values/assets.dart';
import 'package:ticket_module/models/server_response.dart';
import 'package:ticket_module/services/cookie_service.dart';
import 'package:dio/dio.dart';

/// [WebService] is a service for every REST API request to the server
/// and we use Dio for interacting with network.
class WebService {
  CookieService? cookieService;

  WebService({this.cookieService});

  WebService setDependencies(
    CookieService cookieService,
  ) {
    this.cookieService = cookieService;
    log('Web service updated');
    return this;
  }

  final dio = Dio();

  Future<ServerResponse> getFunction(String url, {var body}) async {
    log('requesting data from $url');
    Response? response;
    try {
      var headers = await cookieService!.header(
        withContentType: false,
      );
      dio.options.sendTimeout = 50000;
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;

      response = await dio.get(url,
          options: Options(headers: headers, followRedirects: false));
    } on DioError catch (errorMessage) {
      response = errorMessage.response;
      log('request failed in get method');
    }
    return ServerResponse(response, debugMode: debugMode);
  }

  Future<ServerResponse> postFunction(
    String url, {
    bool withContentType = false,
    var body,
  }) async {
    Response? response;
    try {
      var headers =
          await cookieService!.header(withContentType: withContentType);
      dio.options.sendTimeout = 50000;
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;
      response = await dio.post(
        url,
        options: Options(headers: headers, followRedirects: false),
        data: json.encode(body),
      );
    } on DioError catch (errorMessage) {
      response = errorMessage.response;
      log('request failed in post method');
    }

    return ServerResponse(response, debugMode: debugMode);
  }

  Future<ServerResponse> putFunction(
    String url, {
    bool withContentType = false,
    var body,
  }) async {
    Response? response;
    try {
      var headers =
          await cookieService!.header(withContentType: withContentType);
      dio.options.sendTimeout = 50000;
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;
      response = await dio.put(
        url,
        options: Options(headers: headers, followRedirects: false),
        data: json.encode(body),
      );
      log("response headers are : ${response.headers.toString()}");
    } on DioError catch (errorMessage) {
      response = errorMessage.response;
      log('request failed in put method');
    }
    return ServerResponse(response, debugMode: debugMode);
  }

  Future<ServerResponse> deleteFunction(
    String url, {
    bool withContentType = false,
    var body,
  }) async {
    Response? response;
    try {
      var headers =
          await cookieService!.header(withContentType: withContentType);
      dio.options.sendTimeout = 50000;
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;
      response = await dio.delete(
        url,
        options: Options(headers: headers, followRedirects: false),
        data: json.encode(body),
      );
      log("response headers are : ${response.headers.toString()}");
    } on DioError catch (errorMessage) {
      response = errorMessage.response;
      log('request failed in delete methode');
    }
    return ServerResponse(response, debugMode: debugMode);
  }

  Future<Response<List<int>>> getFunctionWithBytesResponse(String url) async {
    Future<ServerResponse> postMultiPartFunction(
      String url, {
      withContentTypeMultiPart = false,
      var body,
    }) async {
      log('requesting data from $url');
      Response? response;
      try {
        var headers = await cookieService!
            .header(withContentTypeMultiPart: withContentTypeMultiPart);
        var formData = FormData.fromMap(body);
        dio.options.sendTimeout = 150000;
        dio.options.connectTimeout = 150000;
        dio.options.receiveTimeout = 150000;
        response = await dio.post(
          url,
          options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (i) => true),
          data: formData,
        );
        log('response: ${response.statusCode}  ${response.statusMessage}  body: $response');
      } on DioError catch (errorMessage) {
        response = errorMessage.response;
        log('request failed with this error in getFunctionWithBytesResponse : $errorMessage $response');
      }
      return ServerResponse(response!, debugMode: debugMode);
    }

    log('requesting data from $url');
    Response<List<int>>? response;
    try {
      dio.options.sendTimeout = 50000;
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;
      response = await dio.get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));
    } on DioError catch (errorMessage) {
      response = errorMessage.response as Response<List<int>>?;
      log('request failed with this error in getFunctionWithBytesResponse (2): $errorMessage $response');
    }
    return response!;
  }

  Future<ServerResponse> postMultiPartFunction(
    String url, {
    var body,
  }) async {
    log('requesting data from $url');
    Response? response;
    try {
      var headers = await cookieService!.header(withContentTypeMultiPart: true);
      var formData = FormData.fromMap(body);
      dio.options.sendTimeout = 150000;
      dio.options.connectTimeout = 150000;
      dio.options.receiveTimeout = 150000;
      response = await dio.post(
        url,
        options: Options(
            headers: headers,
            followRedirects: false,
            validateStatus: (i) => true),
        data: formData,
      );
      log('response: ${response.statusCode}  ${response.statusMessage}  body: $response');
    } on DioError catch (errorMessage) {
      response = errorMessage.response;
      log('request failed with this error in postMultiPartFunction: $errorMessage $response');
    }
    return ServerResponse(response!, debugMode: debugMode);
  }
}
