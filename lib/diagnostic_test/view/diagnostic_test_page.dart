import 'package:adeo_testapp/diagnostic_test/widgets/diagnostic_test_header.dart';
import 'package:adeo_testapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiagnosticTestPage extends StatelessWidget {
  const DiagnosticTestPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const DiagnosticTestPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const DiagnosticTestView();
  }
}

class DiagnosticTestView extends StatelessWidget {
  const DiagnosticTestView({super.key});

  bool get questionHasExplanation => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DiagnosticTestHeader(),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 150,
            child: Center(
              child: Html(
                  data:
                      r'<p>The equilibrium price of oranges in the market is $20.00. If for some reasons, the price rises to $30.00 there will be</p>',
                  style: {
                    // tables will have the below background color
                    '*': Style(
                      color: Colors.white,
                      fontSize: const FontSize(25),
                      textAlign: TextAlign.center,
                    ),
                  }),
            ),
          ),
          Container(
            color: AppColors.lightSecondary,
            height: 80,
            child: const Center(
              child: Text(
                'Choose the right answer to the question above',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // Question Section
                if (questionHasExplanation)
                  Expanded(
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Row(
                        children: [
                          const QuestionNavButton(
                            icon: Icons.chevron_left,
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 100,
                                    left: 40,
                                    right: 40,
                                    bottom: 50,
                                  ),
                                  child: Column(
                                    children: const [
                                      Text(
                                        'The Story of Ananse',
                                        style: TextStyle(
                                          fontFamily: 'Hamelin',
                                          fontSize: 50,
                                          color: Color(0xFFa5d0ff),
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 5,
                                              color:
                                                  AppColors.reviewDarkTextColor,
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 50),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          const QuestionNavButton(
                            icon: Icons.chevron_right,
                          ),
                        ],
                      ),
                    ),
                  ),
                // End of Question Section

                // Start of Answer Section
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 30),
                    color: AppColors.darkBlue,
                    child: Column(children: [
                      const SizedBox(height: 50),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return AnswerItem(
                              index: index,
                              text: "Howll you",
                            );
                          },
                        ),
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: AnswerNavButton(text: 'Previous'),
                          ),
                          SizedBox(width: 1),
                          Expanded(
                            child: AnswerNavButton(text: 'Next'),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
                // End of Answer Section
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AnswerItem extends StatelessWidget {
  const AnswerItem({
    super.key,
    required this.index,
    required this.text,
  });

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                index.isEven ? Theme.of(context).primaryColor : Colors.red,
            child: Icon(
              index.isEven ? Icons.check : Icons.close,
              size: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 40, color: AppColors.lightSecondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuestionNavButton extends StatelessWidget {
  const QuestionNavButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => print('Next'),
      icon: Icon(icon),
      iconSize: 70,
      color: AppColors.lightSecondary,
    );
  }
}

class AnswerNavButton extends StatelessWidget {
  const AnswerNavButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () => print(text),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side: BorderSide.none,
          primary: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
