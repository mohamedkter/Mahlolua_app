import 'dart:io';
import 'package:dio/dio.dart';

Future<FormData> imageConverter(File file,String key) async {
  String fileName = file.path.split('/').last;
  return FormData.fromMap({
    "$key": await MultipartFile.fromFile(file.path, filename: fileName),
    "type":"image/png"
  });
}