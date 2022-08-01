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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'diagnostic_test/view/diagnostic_test_page.dart' as _i2;
import 'welcome/welcome.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.WelcomePage());
    },
    DiagnosticTestRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.DiagnosticTestPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(WelcomeRoute.name, path: '/'),
        _i3.RouteConfig(DiagnosticTestRoute.name, path: '/diagnostic-test-page')
      ];
}

/// generated route for
/// [_i1.WelcomePage]
class WelcomeRoute extends _i3.PageRouteInfo<void> {
  const WelcomeRoute() : super(WelcomeRoute.name, path: '/');

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i2.DiagnosticTestPage]
class DiagnosticTestRoute extends _i3.PageRouteInfo<void> {
  const DiagnosticTestRoute()
      : super(DiagnosticTestRoute.name, path: '/diagnostic-test-page');

  static const String name = 'DiagnosticTestRoute';
}
