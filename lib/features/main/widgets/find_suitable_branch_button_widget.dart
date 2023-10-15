import 'package:flutter/material.dart';
import 'package:promenade/common/app_colors.dart';
import 'package:promenade/common/text_styles.dart';
import 'package:promenade/features/main/pages/chat_screen.dart';

class FindSuitableBranchButtonWidget extends StatelessWidget {
  const FindSuitableBranchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(56.0),
              gradient: accent,
            ),
            child: Text(
              'Найти подходящее отделение',
              textAlign: TextAlign.end,
              style: buttonTextStyle.copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              top: 28.0,
            ),
            child: Image.asset(
              'assets/images/robot.png',
              height: 84.0,
              width: 62.0,
            ),
          ),
        ],
      ),
    );
  }
}
