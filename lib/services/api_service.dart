import 'package:dio/dio.dart';
import '../models/image_response.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  Future<ImageResponse> getRandomImage() async {
    try {
      final response = await _dio.get('/image/');
      if (response.statusCode == 200) {
        return ImageResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
