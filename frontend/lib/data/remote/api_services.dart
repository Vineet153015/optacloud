import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://localhost:5000/api"));

  Future<void> syncHealthData(List<Map<String, dynamic>> healthRecords) async {
    try {
      await _dio.post('/health', data: {'records': healthRecords});
    } catch (e) {
      throw Exception("Failed to sync data: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchHealthData() async {
    try {
      final response = await _dio.get('/health');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }
}
