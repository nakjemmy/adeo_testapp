import 'package:adeo_testapp/diagnostic_test/api/diagnostic_test_api.dart';

import 'package:adeo_testapp/diagnostic_test/models/question.dart';

class DiagnosticTestRepository {
  const DiagnosticTestRepository({
    required DiagnosticTestApi diagnosticTestApi,
  }) : _diagnosticTestApi = diagnosticTestApi;

  final DiagnosticTestApi _diagnosticTestApi;

  Future<List<Question>> getQuestions({
    int levelId = 1,
    int courseId = 1,
    int limit = 20,
  }) async {
    final result = await _diagnosticTestApi.getQuestions();
    print(result);
    return result;
  }
}
