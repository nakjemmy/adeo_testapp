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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the \nAdeo Experience',
              style: TextStyle(
                fontFamily: 'Hamelin',
                fontSize: 50,
                color: Colors.white,
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
                onPressed: () => print('Hello Jerry'),
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
    );
  }
}
