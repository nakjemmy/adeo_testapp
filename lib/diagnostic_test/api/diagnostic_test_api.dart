import 'dart:convert';

import 'package:adeo_testapp/diagnostic_test/models/question.dart';
import 'package:adeo_testapp/diagnostic_test/models/questions_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DiagnosticTestApi {
  /// {@macro todos_api}
  const DiagnosticTestApi({required this.baseApiUrl});

  final String baseApiUrl;

  /// Provides a [Future] of questions
  Future<List<Question>> getQuestions({
    int levelId = 1,
    int courseId = 1,
    int limit = 20,
  }) async {
    final url = Uri.parse(baseApiUrl);
    print(url);
    final newUrl = url.replace(
      queryParameters: {
        'level_id': levelId.toString(),
        'course_id': courseId.toString(),
        'limit': limit.toString(),
      },
      path: '/api/questions/get',
    );
    print(newUrl);

    try {
      final response = await http.get(newUrl);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        print(jsonResponse['code']);
        final questionResponse = QuestionsResponse.fromJson(jsonResponse);

        return questionResponse.data;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('ERROR $e');
      }
      rethrow;
    }
  }
}
