// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:adeo_testapp/diagnostic_test/api/diagnostic_test_api.dart';
import 'package:adeo_testapp/diagnostic_test/bloc/diagnostic_test_bloc.dart';
import 'package:adeo_testapp/diagnostic_test/bloc/timer_bloc.dart';
import 'package:adeo_testapp/diagnostic_test/repositories/diagnostic_test_repository.dart';
import 'package:adeo_testapp/diagnostic_test/timer.dart';
import 'package:adeo_testapp/l10n/l10n.dart';
import 'package:adeo_testapp/routes.gr.dart';
import 'package:adeo_testapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => const DiagnosticTestRepository(
        diagnosticTestApi: DiagnosticTestApi(baseApiUrl: 'https://adeo.app/'),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DiagnosticTestBloc(
              diagnosticTestRepository:
                  context.read<DiagnosticTestRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => TimerBloc(ticker: const Ticker()),
          )
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
            primaryColor: AppColors.primaryColor,
            primaryColorDark: AppColors.primaryColorDark,
            colorScheme: ColorScheme.fromSwatch(
              accentColor: AppColors.secondaryColor,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                onPrimary: Colors.white,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
