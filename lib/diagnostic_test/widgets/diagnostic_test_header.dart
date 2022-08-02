// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class DiagnosticTestHeader extends StatelessWidget {
  const DiagnosticTestHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: double.maxFinite,
        child: Stack(
          children: [
            const SizedBox(
              width: 400,
              child: QuestionNumbers(),
            ),
            Positioned(
              top: 0,
              right: -10,
              child: Stack(
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/header_right.png'),
                  ),
                  Positioned(
                    right: 25,
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
                          '01:02',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionNumbers extends StatelessWidget {
  const QuestionNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    final data = List.generate(20, (index) => index + 1);
    final selectedIndex = data[0];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  data[index].toString(),
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.white54,
                    fontSize: 40,
                  ),
                ),
                if (selected)
                  Container(
                    width: 40,
                    height: 5,
                    color: Colors.white,
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
