import 'package:flutter/material.dart';
import 'package:promenade/common/app_colors.dart';
import 'package:promenade/features/main/pages/router_choice_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int count = 0;

  List<Widget> story = [
    Image.network('https://i.imgur.com/sVmITKx.png'),
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.network(
        'https://i.imgur.com/6fdQUcP.png',
        height: 80.0,
        alignment: Alignment.centerRight,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.network(
        'https://i.imgur.com/itqlZol.png',
        height: 80.0,
        alignment: Alignment.centerLeft,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.network(
        'https://i.imgur.com/1UXPPaJ.png',
        height: 40.0,
        alignment: Alignment.centerRight,
      ),
    ),
    Image.network(
      'https://i.imgur.com/BGTcBvX.png',
      height: 110.0,
      alignment: Alignment.centerLeft,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (count == 5) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RouterChoiceScreen()));
          } else {
            count++;
          }
        });
      },
      child: Scaffold(
        backgroundColor: blue,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < count; i++) ...[story[i]],
            ],
          ),
        ),
      ),
    );
  }
}
