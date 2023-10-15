import 'package:flutter/material.dart';
import 'package:promenade/features/main/widgets/draggable_scrollable_sheet_widget.dart';
import 'package:promenade/features/main/widgets/find_suitable_branch_button_widget.dart';
import 'package:promenade/features/main/widgets/yandex_map_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          YandexMapWidget(),
          FindSuitableBranchButtonWidget(),
          DraggableScrollableSheetWidget(),
        ],
      ),
    );
  }
}
