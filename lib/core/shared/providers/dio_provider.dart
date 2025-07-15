import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epilearn/core/networking/dio_client.dart';

final dioProvider = Provider<Dio>((ref) {
  final client = DioClient();
  return client.dio;
});
