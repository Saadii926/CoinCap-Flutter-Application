import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/app_config.dart';
import 'package:get_it/get_it.dart';

// Dio is used to interect with service client and it gives us the ability to send, get request, post requests and all other sorts of things that are usually related to working with rest API or other web serives

class HTTPServies {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _baseUrl;

  HTTPServies() {
    _appConfig = GetIt.instance<AppConfig>();
    _baseUrl = _appConfig!.urlApiBaseUrl;
    // print(_baseUrl);
  }

  Future<Response?> get(String path) async {
    try {
      String url = "$_baseUrl$path";
      Response response = await dio.get(url);
      return response;
    } catch (e) {
      debugPrint("HTTPService: Unable to Perform get request.");
      debugPrint(e.toString());
    }
    return null;
  }
}
