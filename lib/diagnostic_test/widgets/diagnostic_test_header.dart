// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class DiagnosticTestHeader extends StatelessWidget {
  const DiagnosticTestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: const [QuestionNumbers()],
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
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  data[index].toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
                if (index == selectedIndex)
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
