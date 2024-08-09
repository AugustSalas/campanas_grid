import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiCampaigns {
  static Dio dio = Dio();
  static Dio dio2 = Dio();

  static void configureDio() {
    dio.options.baseUrl = dotenv.env['URL_CRM_BFF_CAMPANAS']!;
    dio2.options.baseUrl = dotenv.env['URL_CONFIGURATION']!;
  }

  static Future httpGet(String path) async {
    try {
      final resp = await dio.get(path);
      return resp.data;
    } on DioException {
      throw ('Error en el GET');
    }
  }

  static Future httpGet2(String path) async {
    try {
      final resp = await dio2.get(path);
      return resp.data;
    } on DioException {
      throw ('Error en el GET');
    }
  }

  // static Future post(String path, Map<String, dynamic> data) async {
  //   final formData = FormData.fromMap(data);
  //   try {
  //     final resp = await dio.post(path, data: formData);
  //     return resp.data;
  //   } on DioException catch (e) {
  //   return Future.error('Error en el POST: ${e.message}');
  // }
  // }
  static Future<Response> post(String path, Map<String, dynamic> data) async {
    var jsonComentario = jsonEncode(data);

    try {
      final resp = await dio.post(
        path,
        data: jsonComentario,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      return resp;
    } on DioException catch (e) {
      return Future.error('Error en el POST: ${e.message}');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await dio.put(path, data: formData);
      return resp.data;
    } on DioException catch (e) {
      throw ('Error en el PUT $e');
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await dio.delete(path, data: formData);
      return resp.data;
    } catch (e) {
      throw ('Error en el DELETE');
    }
  }

  static Future uploadFile(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});
    try {
      final resp = await dio.put(path, data: formData);
      return resp.data;
    } on DioException catch (e) {
      throw ('Error en el PUT $e');
    }
  }
}
