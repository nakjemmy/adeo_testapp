// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:adeo_testapp/diagnostic_test/view/diagnostic_test_page.dart';
import 'package:adeo_testapp/welcome/welcome.dart';
import 'package:auto_route/annotations.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomePage, initial: true),
    AutoRoute(page: DiagnosticTestPage),
  ],
)
class $AppRouter {}
