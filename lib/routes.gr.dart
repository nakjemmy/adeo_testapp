// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import 'diagnostic_test/view/diagnostic_test_page.dart' as _i2;
import 'diagnostic_test/view/diagnostic_test_review_page.dart' as _i3;
import 'welcome/welcome.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.WelcomePage());
    },
    DiagnosticTestRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.DiagnosticTestPage());
    },
    DiagnosticTestReviewRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.DiagnosticTestReviewPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(WelcomeRoute.name, path: '/'),
        _i4.RouteConfig(DiagnosticTestRoute.name, path: '/diagnostic-test'),
        _i4.RouteConfig(DiagnosticTestReviewRoute.name,
            path: '/diagnostic-test-review')
      ];
}

/// generated route for
/// [_i1.WelcomePage]
class WelcomeRoute extends _i4.PageRouteInfo<void> {
  const WelcomeRoute() : super(WelcomeRoute.name, path: '/');

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i2.DiagnosticTestPage]
class DiagnosticTestRoute extends _i4.PageRouteInfo<void> {
  const DiagnosticTestRoute()
      : super(DiagnosticTestRoute.name, path: '/diagnostic-test');

  static const String name = 'DiagnosticTestRoute';
}

/// generated route for
/// [_i3.DiagnosticTestReviewPage]
class DiagnosticTestReviewRoute extends _i4.PageRouteInfo<void> {
  const DiagnosticTestReviewRoute()
      : super(DiagnosticTestReviewRoute.name, path: '/diagnostic-test-review');

  static const String name = 'DiagnosticTestReviewRoute';
}
