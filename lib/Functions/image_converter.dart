import 'dart:io';
import 'package:dio/dio.dart';

Future<FormData> imageConverter(File file) async {
  String fileName = file.path.split('/').last;
  return FormData.fromMap({
    "image": await MultipartFile.fromFile(file.path, filename: fileName),
    "type":"image/png"
  });
}