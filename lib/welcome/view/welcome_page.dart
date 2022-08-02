import 'package:adeo_testapp/routes.gr.dart';
import 'package:adeo_testapp/theme/colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const WelcomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const WelcomeView();
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: -5,
            right: -10,
            child: Stack(
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/header_right.png'),
                ),
                Positioned(
                  right: 35,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            'You pressed skip',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Skip',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to the \nAdeo Experience',
                  style: TextStyle(
                    fontFamily: 'Hamelin',
                    fontSize: 50,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 5,
                        color: AppColors.reviewDarkTextColor,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                RichText(
                  text: const TextSpan(
                    text: 'You currently have',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\nNO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' Subscriptions.'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'First take a diagnostic test \nto determine the right \ncourse for you.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: OutlinedButton(
                    onPressed: () =>
                        context.router.push(const DiagnosticTestRoute()),
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: const Text(
                      "Let's Go",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
